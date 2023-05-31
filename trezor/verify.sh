#!/bin/bash
# [rights]  Copyright 2023 brianddk at github https://github.com/brianddk
# [license] Apache 2.0 License https://www.apache.org/licenses/LICENSE-2.0
# [repo]    github.com/brianddk/attestation/
# [ref]     reddit.com/r/TREZOR/comments/to2e6h/
# [ref]     reddit.com/r/TREZOR/comments/13k92nw/
# [ref]     github.com/trezor/data/tree/master/firmware
# [ref]     github.com/trezor/trezor-firmware/issues/2189#issuecomment-1558802760
# [ref]     github.com/trezor/trezor-firmware/blob/30a77a7/docs/common/reproducible-build.md
# [btc]     BTC-b32: bc1qwc2203uym96u0nmq04pcgqfs9ldqz9l3mz8fpj
# [tipjar]  github.com/brianddk/reddit/blob/master/tipjar/tipjar.txt
# [req]     bash, docker, git, gpg, wget, dd, sha256sum, python-venv
# [note]    This script will run the official `docker-build.sh` script from
# [note]      the `trezor-firmware` github repository to make a reproducible
# [note]      build binary.  It also performs the added steps of removing the
# [note]      signature and comparing local and publish builds for 'sameness'
# [windows] wsl GPG_BIN=gpg.exe trezor/verify.sh --gpg-key YOUR_UID core/v2.6.0
# [linux]   trezor/verify.sh --gpg-key YOUR_UID --latest-rel
# [macOS]   trezor/verify.sh --gpg-key YOUR_UID --canary-rel

VERSION=0.2
LATEST="core/bl2.1.0 core/v2.6.0 legacy/bl1.12.1 legacy/v1.12.1"
CANARY="core/bl2.1.0 core/v2.6.0 legacy/bl1.12.1 legacy/v1.12.1"
# bl2.0.3 is SO old it will require some archeology to build.
# bl1.11.0 fails, and I don't know why
#PREVIOUS="core/bl2.0.3 core/v2.5.3 legacy/bl1.11.0 legacy/v1.11.2"
PREVIOUS="core/v2.5.3 legacy/v1.11.2"
CANARY_URL="https://trezor.io/transparency/canary.txt"
REPOSITORY="https://github.com/trezor/trezor-firmware.git"
GPG_BIN=${GPG_BIN:-gpg}
TEMPFILE="$(mktemp)"
EXEC_PATH=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
source "${EXEC_PATH}/settings.sh"

# Helper function to compare version strings
function version_a_lt_b () {
  if [[ $1 == $2 ]]; then
    return 1 # False
  fi
  ORIG=$(echo -e "$1\n$2")
  RESULT=$(echo -e "$ORIG" | sort --version-sort)
  if [[ "$ORIG" == "$RESULT" ]]; then
    return 0 # True (non error return)
  else
    return 1 # False (error return)
  fi
}


# Main verify function
function verify () {
  TAG=$1
  FILE="attest/${TAG}/attest"
  BUILD_DOCKER=${dock_bld_sh[$TAG]:-"build-docker.sh"}
  
  # Make VENV for headertool.py
  if [ -d .venv ]; then
    source .venv/bin/activate    
  else
    # sudo apt install python3-venv python3-wheel python3-setuptools python3-pip
    python3 -m venv .venv
    source .venv/bin/activate
    python3 -m pip install --upgrade pip setuptools wheel
    python3 -m pip install repo/python/. || exit 9
  fi

  # determine if we are bootloader or not, and core -vs- legacy
  case "$TAG" in
  "core/v"*)
    VER="${TAG:6}"
    IS_CORE=1
    IS_BLDR=0    
    ;;
  "legacy/v"*)
    VER="${TAG:8}"
    IS_CORE=0
    IS_BLDR=0    
    ;;
  "core/bl"*)
    VER="${TAG:7}"
    IS_CORE=1
    IS_BLDR=1    
    ;;
  "legacy/bl"*)
    VER="${TAG:9}"
    IS_CORE=0
    IS_BLDR=1    
    ;;
  *)
    echo "BAD TAG!!"
    exit 10
    ;;
  esac
  
  # Make directories and repos as needed
  mkdir -p "attest/$TAG"
  if [ ! -d repo ]; then
    git clone -b $TAG "${REPOSITORY}" repo || exit 5
    1> /dev/null pushd repo
  else
  # Using explicit paths in GIT due to WSL weirdness
  1> /dev/null pushd repo
  git restore "$PWD" || exit 1
    git checkout "${dock_bld_ver[$TAG]}" --force || exit 3
  git clean --force || exit 2
  fi

  for i in ${bld_files[$TAG]}; do
    mkdir -p "$(dirname $i)"
    touch "$i"
  done
  echo bash $BUILD_DOCKER ${bld_opt[$TAG]} "${ctnr_src_ver[$TAG]}"
  # read
  bash $BUILD_DOCKER ${bld_opt[$TAG]} "${ctnr_src_ver[$TAG]}"
  if [ $IS_BLDR -eq 1 ]; then
    cd $(dirname "${prd_files[$TAG]}")
    git restore -s "${prd_bin_ver[$TAG]}" -- $(basename "${prd_files[$TAG]}") || exit 3
  fi
  1> /dev/null popd

  # Do checksum'ing in one block to catch and log
  (
    echo "verify.sh Version:       $VERSION"
    echo "Intended Build Version:  $TAG"
    echo "build-docker.sh Version: ${dock_bld_ver[$TAG]}"
    echo "Build Command:           build-docker.sh ${bld_opt[$TAG]} ${ctnr_src_ver[$TAG]}"
    echo "Bootloader Build?:       $IS_BLDR"
    if [ $IS_BLDR -eq 1 ]; then # is_bootloader=True
      echo "Source Binary tag:       ${prd_bin_ver[$TAG]}"
    else
      echo "DD Zero Sig Options:     ${dd_zero_opts[$TAG]}"      
    fi
    if [[ ! -z ${note[$TAG]} ]]; then
      echo -e "Relevant Build Notes:    ${note[$TAG]}"
    fi
    echo ""
    if [ $IS_BLDR -eq 1 ]; then # is_bootloader=True
      if [ $IS_CORE -eq 1 ]; then # is_core=True   
        for i in ${prd_files[$TAG]} ${bld_files[$TAG]}
        do
          # Let headertool.py pull out the important bits, then swap field order
          bldr=$(realpath --relative-to="${EXEC_PATH}" "${i}")
          2>/dev/null repo/core/tools/headertool.py -h $bldr | grep "^Finger" | sed "s#^Finger.*:#$bldr#g" | awk '{print $2 "  " $1}'
        done
      else # is_core=False   
        sha256sum $(realpath --relative-to=${EXEC_PATH} ${prd_files[$TAG]}) $(realpath --relative-to=${EXEC_PATH} ${bld_files[$TAG]})
      fi # is_core
    else # is_bootloader=False
      read PRD_NRML PRD_BO <<< "${prd_files[$TAG]}"
      read BLD_NRML BLD_BO <<< "${bld_files[$TAG]}"

      for i in $PRD_BO $PRD_NRML;
      do
        BINFILE="$(basename $i)"
        # Get the official production bins
        wget -qO ${BINFILE} https://data.trezor.io/firmware/${i} || exit 4
        
        # Strip off legacy header
        if version_a_lt_b "${VER}" "1.12.1"; then
          tail -c +257 ${BINFILE} > ${BINFILE}.nohdr
          mv ${BINFILE}.nohdr ${BINFILE}
        fi

        # Thunk out the header signature
        dd if=/dev/zero of=${BINFILE} ${dd_zero_opts[$TAG]}
      done

      sha256sum $(basename $PRD_NRML) $(realpath --relative-to=$EXEC_PATH $BLD_NRML); 
      if [[ ! -z $PRD_BO && ! -z $BLD_BO ]]; then
        echo ""
      sha256sum $(basename $PRD_BO) $(realpath --relative-to=$EXEC_PATH $BLD_BO)
      fi
    fi # is_bootloader
  ) | tee "${TEMPFILE}"
  < "${TEMPFILE}" ${GPG_BIN} --clear-sign -u "${GPG_KEY}" > "${FILE}.${GPG_KEY}"
}


# Attest that the Canary is reachable and signed
function do_canary() {
  FILE="attest/canary/attest"

  mkdir -p attest/canary
  curl -s "${CANARY_URL}" | ${GPG_BIN} --verify 2>&1 \
    | ${GPG_BIN} --clear-sign -u "${GPG_KEY}" > "${FILE}.${GPG_KEY}"
}


# Verify that the named key is in your keyring
function test_key() {
  KEYFILE="../pubkeys/${GPG_KEY}.asc"
  # Attempt to save the key into the repo "keyring"
  if ${GPG_BIN} -a --export "${GPG_KEY}" 1> "${KEYFILE}" 2> /dev/null; then
    echo "Using GPG key UID=${GPG_KEY}"
  else
    echo "FAILED Key test of UID ${GPG_KEY}"
    exit 11
  fi
}


# Show help
function help_and_die() {
  echo "Version ${VERSION}"
  echo ""
  echo "Usage: $0 --gpg-key UID [options] [tag]"
  echo "Options:"
  echo "  --gpg-key UID - do attestment with the named UID"
  echo "  --canary-file - attest that the canary URL is signed and reachable"
  echo "  --latest-rel  - attest firmware based on the latest releases"
  echo "  --prev-rel    - attest firmware based on 'latest - 1'"
  echo "  --canary-rel  - attest latest firmware released before the last canary"
  exit 0
}


# The main entrypoint
function main () {
  # move to this scripts directory
  cd "${EXEC_PATH}"
  # parse args
  while true; do
    case "$1" in
      -h|--help)
        help_and_die
        ;;
      --gpg-key)
        GPG_KEY="$2"
        shift 2
        ;;
      --canary-file)
        DO_CANARY=1
        shift
        ;;
      --latest-rel)
        TAGS="${LATEST}"
        shift
        ;;
      --prev-rel)
        TAGS="${PREVIOUS}"
        shift
        ;;
      --canary-rel)
        TAGS="${CANARY}"
        shift
        ;;
      *)
        break
        ;;
    esac
  done

  # if no "--at-" options named, pull tags from args()
  TAGS=${TAGS:-$*}

  # must name a GPG key
  if [[ -z "${GPG_KEY}" ]]; then
    help_and_die
  else
    test_key
  fi

  # attest the canary if told to do so
  if [[ -v DO_CANARY ]]; then
    do_canary
  fi

  # attest based on tags
  for i in $TAGS; do
    if [[ -z ${is_hash_eq[$i]} ]]; then
      echo "Bad TAG: [$i]"
      exit 1
    elif [ ! ${is_hash_eq[$i]} -eq 1 ]; then
      echo "Build of '$i' is UNTESTED, proceed with caution"
      echo "PRESS ANY KEY to continue"
      read
    fi
    verify "$i"
  done # do $TAGS

  # collect garbage
  rm "${TEMPFILE}"
}

# The actual entrypoint
main $*
