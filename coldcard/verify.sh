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

declare -A mk_cmd


mk_cmd["2023-06-20T1506-v6.1.0X"]="make -f MK4-Makefile repro"
mk_cmd["2023-05-12T1317-v6.0.0X"]="make -f MK4-Makefile repro"
mk_cmd["2023-04-07T1330-v5.1.2"]="make -f MK4-Makefile repro"
mk_cmd["2023-02-27T2106-v5.1.1"]="make -f MK4-Makefile repro" # NOT 2023-02-27T2105-v5.1.1
mk_cmd["2023-02-27T1509-v5.1.0"]="make -f MK4-Makefile repro"
mk_cmd["2022-10-05T1724-v5.0.7"]="make -f MK4-Makefile repro"
mk_cmd["2022-07-29T1816-v5.0.6"]="make -f MK4-Makefile repro"
mk_cmd["2022-07-20T1508-v5.0.5"]="make -f MK4-Makefile repro"
mk_cmd["2022-05-27T1500-v5.0.4"]="make -f MK4-Makefile repro"
mk_cmd["2022-05-04T1252-v5.0.3"]="make -f MK4-Makefile repro"
mk_cmd["2022-04-19T1805-v5.0.2"]="make -f MK4-Makefile repro"
mk_cmd["2022-03-24T1643-v5.0.1"]="make -f MK4-Makefile repro"
mk_cmd["2022-03-14T1907-v5.0.0"]="make -f MK4-Makefile repro"
mk_cmd["2023-06-19T1627-v4.1.8"]="make -f Makefile repro"
mk_cmd["2022-11-14T1854-v4.1.7"]="make -f Makefile repro"
mk_cmd["2022-10-05T1517-v4.1.6"]="make -f Makefile repro"
mk_cmd["2022-05-04T1258-v4.1.5"]="make -f Makefile repro" # Dockerfile:23 | >>> RUN ln -s /usr/bin/python3 /usr/bin/python ( <== file exists )
mk_cmd["2022-04-25T1618-v4.1.4"]="make -f Makefile repro" # Dockerfile:23 | >>> RUN ln -s /usr/bin/python3 /usr/bin/python ( <== file exists )
mk_cmd["2021-09-02T1752-v4.1.3"]="make -f Makefile repro" # Dockerfile:23 | >>> RUN ln -s /usr/bin/python3 /usr/bin/python ( <== file exists )
mk_cmd["2021-07-28T1347-v4.1.2"]="make -f Makefile repro"
mk_cmd["2021-04-07T1424-v4.0.2"]="make -f Makefile repro"
mk_cmd["2021-03-29T1927-v4.0.1"]="make -f Makefile repro"
mk_cmd["2021-01-14T1617-v3.2.2"]="make -f Makefile repro"
mk_cmd["2021-01-07T1439-v3.2.1"]="make -f Makefile repro"
mk_cmd["2019-12-19T1623-v3.0.6"]="make -f Makefile repro"

VERSION=0.2
TAG=$1
if [[ -z ${mk_cmd[$TAG]} ]]; then
  echo "Bad tag: [$TAG]"
  exit 1
fi

EXEC_PATH=$PWD
REPOSITORY="https://github.com/Coldcard/firmware.git"
TEMPFILE="$(mktemp)"
GPG_BIN=${GPG_BIN:-"gpg"}
GPG_KEY=${GPG_KEY:-"temp"} #name in execution GPG_KEY=temp ./verify.sh

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

# must name a GPG key
if [[ -z "${GPG_KEY}" ]]; then
  echo "Must name a GPG_KEY"
  exit 2
else
  test_key
fi

# Make directories and repos as needed
mkdir -p "${EXEC_PATH}/attest/$TAG"
if [ ! -d repo ]; then
  git clone -b $TAG "${REPOSITORY}" repo || exit 5
  1> /dev/null pushd ${EXEC_PATH}/repo
else
  # Using explicit paths in GIT due to WSL weirdness
  1> /dev/null pushd ${EXEC_PATH}/repo
  git restore "$PWD" || exit 1
  git checkout "$TAG" --force || exit 3
  git clean --force || exit 2
fi

1>/dev/null pushd ${EXEC_PATH}/repo/stm32
FILE="${EXEC_PATH}/attest/$TAG/attest"
echo ${mk_cmd[$TAG]}
# read
${mk_cmd["$TAG"]} 2>&1 | tee $TEMPFILE
_line=$(grep -n "^Comparing against:" $TEMPFILE | cut -d":" -f1)
(
  echo "verify.sh Version:       $VERSION"
  echo "Intended Build Version:  $TAG"
  echo "repro-build.sh Version:  $TAG"
  echo "Build Command:           ${mk_cmd[$TAG]}"
  echo ""

  tail -n +$_line $TEMPFILE
) | ${GPG_BIN} --clear-sign -u "${GPG_KEY}" > "${FILE}.${GPG_KEY}"

# rm $TEMPFILE

echo $TEMPFILE $_line