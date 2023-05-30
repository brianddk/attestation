#!/bin/bash
# [rights]  Copyright 2023 brianddk at github https://github.com/brianddk
# [license] Apache 2.0 License https://www.apache.org/licenses/LICENSE-2.0
# [repo]    github.com/brianddk/attestation/
# [btc]     BTC-b32: bc1qwc2203uym96u0nmq04pcgqfs9ldqz9l3mz8fpj
# [tipjar]  github.com/brianddk/reddit/blob/master/tipjar/tipjar.txt
# [req]     bash, grep, dirname, realpath

EXEC_PATH=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
REAL_PATH=$(realpath --relative-to="$PWD" "${EXEC_PATH}")
if [[ -z "${REAL_PATH}" ]]; then
  REAL_PATH=.
fi

TARG_PATH=${1:-$REAL_PATH/attest}
grep -r " repo/\| trezor-" "${TARG_PATH}"
