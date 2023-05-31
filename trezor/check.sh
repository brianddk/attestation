#!/bin/bash
# [rights]  Copyright 2023 brianddk at github https://github.com/brianddk
# [license] Apache 2.0 License https://www.apache.org/licenses/LICENSE-2.0
# [repo]    github.com/brianddk/attestation/
# [btc]     BTC-b32: bc1qwc2203uym96u0nmq04pcgqfs9ldqz9l3mz8fpj
# [tipjar]  github.com/brianddk/reddit/blob/master/tipjar/tipjar.txt
# [req]     bash, grep, dirname, realpath

EXEC_PATH=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
source "${EXEC_PATH}/settings.sh"

TARG_PATH=${1:-$REAL_PATH/attest}
DUMP=${2:-""}

function main() {
  lhash=""
  i=0
  while IFS= read -r line; do
    read afile vhash bfile <<< $(awk -F '[: ]+' '{print $1, $2, $3}' <<<"$line")
    atag="$(basename $(dirname $afile))            "
    echo "${atag::9} $vhash  $bfile"
    ((i++))
    if (( i % 2 == 0 )); then
      if [ "$lhash" != "$vhash" ] && [ -z "$DUMP" ]; then
        echo "Hash of $bfile in build ${atag::9} FAILED"
        exit 1
      fi
    fi
    lhash=$vhash
  done <<< $(grep -r " repo/\| trezor-" "${TARG_PATH}")
}

main $@
