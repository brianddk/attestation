#!/bin/bash
# [rights]  Copyright 2023 brianddk at github https://github.com/brianddk
# [license] Apache 2.0 License https://www.apache.org/licenses/LICENSE-2.0
# [btc]     BTC-b32: bc1qwc2203uym96u0nmq04pcgqfs9ldqz9l3mz8fpj
# [tipjar]  github.com/brianddk/reddit/blob/master/tipjar/tipjar.txt
# [req]     bash, dirname, realpath, basename, find

EXEC_PATH=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
REAL_PATH=$(grealpath --relative-to="$PWD" "${EXEC_PATH}")
if [[ -z "${REAL_PATH}" ]]; then
  REAL_PATH=.
fi

echo "SUCCEEDED"
for i in $(find "${REAL_PATH}/attest" -name "attest.*")
do 
  echo "  $(basename $(dirname $i))"
done

if [ -d "${REAL_PATH}/failed" ]; then
  echo ""; echo "FAILED"
  for i in $(find "${REAL_PATH}/failed" -name "attest.*")
  do 
    echo "  $(basename $(dirname $i))"
  done
fi
