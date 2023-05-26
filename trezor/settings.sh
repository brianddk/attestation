#!/bin/bash
# [rights]  Copyright 2023 brianddk at github https://github.com/brianddk
# [license] Apache 2.0 License https://www.apache.org/licenses/LICENSE-2.0
# [repo]    github.com/brianddk/attestation/
# [btc]     BTC-b32: bc1qwc2203uym96u0nmq04pcgqfs9ldqz9l3mz8fpj
# [tipjar]  github.com/brianddk/reddit/blob/master/tipjar/tipjar.txt
# [req]     bash
# [note]    This script is intended to be sourced from verify.sh.  It serves
# [note]      as a global settings data structure to do all the builds that
# [note]      have source tags in Trezor's github

# The required version for build-docker.sh and Dockerfile
declare -A dock_bld_ver
# The required tag argument to the build-docker.sh script
declare -A ctnr_src_ver
# (BL-only) The version that the Bootloader refence binary was checked-in under
declare -A  prd_bin_ver
# The options passed to the build-docker.sh script
declare -A      bld_opt
# The PATHs or URL fragments to the official released production binaries
declare -A    prd_files
# The PATHs to the resulting built binaries to compare
declare -A    bld_files
# (FW-only) The DD arguments to zero-out the firmware signatures
declare -A dd_zero_opts
# Whether or not this tag has passed reproducible build test
declare -A   is_hash_eq

dock_bld_ver["core/v2.6.0"]="core/v2.6.0"
ctnr_src_ver["core/v2.6.0"]="core/v2.6.0"
     bld_opt["core/v2.6.0"]="--skip-legacy"
   prd_files["core/v2.6.0"]="2/trezor-2.6.0.bin 2/trezor-2.6.0-bitcoinonly.bin"
   bld_files["core/v2.6.0"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.6.0"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.6.0"]=1

dock_bld_ver["core/v2.5.3"]="core/v2.5.3"
ctnr_src_ver["core/v2.5.3"]="core/v2.5.3"
     bld_opt["core/v2.5.3"]="--skip-legacy"
   prd_files["core/v2.5.3"]="2/trezor-2.5.3.bin 2/trezor-2.5.3-bitcoinonly.bin"
   bld_files["core/v2.5.3"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.5.3"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.5.3"]=1

dock_bld_ver["core/v2.5.2"]="core/v2.5.2"
ctnr_src_ver["core/v2.5.2"]="core/v2.5.2"
     bld_opt["core/v2.5.2"]="--skip-legacy"
   prd_files["core/v2.5.2"]="2/trezor-2.5.2.bin 2/trezor-2.5.2-bitcoinonly.bin"
   bld_files["core/v2.5.2"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.5.2"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.5.2"]=0

dock_bld_ver["core/v2.5.1"]="core/v2.5.1"
ctnr_src_ver["core/v2.5.1"]="core/v2.5.1"
     bld_opt["core/v2.5.1"]="--skip-legacy"
   prd_files["core/v2.5.1"]="2/trezor-2.5.1.bin 2/trezor-2.5.1-bitcoinonly.bin"
   bld_files["core/v2.5.1"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.5.1"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.5.1"]=0

dock_bld_ver["core/v2.4.3"]="core/v2.4.3"
ctnr_src_ver["core/v2.4.3"]="core/v2.4.3"
     bld_opt["core/v2.4.3"]="--skip-legacy"
   prd_files["core/v2.4.3"]="2/trezor-2.4.3.bin 2/trezor-2.4.3-bitcoinonly.bin"
   bld_files["core/v2.4.3"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.4.3"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.4.3"]=0

dock_bld_ver["core/v2.4.2"]="core/v2.4.2"
ctnr_src_ver["core/v2.4.2"]="core/v2.4.2"
     bld_opt["core/v2.4.2"]="--skip-legacy"
   prd_files["core/v2.4.2"]="2/trezor-2.4.2.bin 2/trezor-2.4.2-bitcoinonly.bin"
   bld_files["core/v2.4.2"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.4.2"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.4.2"]=0

dock_bld_ver["core/v2.4.1"]="core/v2.4.1"
ctnr_src_ver["core/v2.4.1"]="core/v2.4.1"
     bld_opt["core/v2.4.1"]="--skip-legacy"
   prd_files["core/v2.4.1"]="2/trezor-2.4.1.bin 2/trezor-2.4.1-bitcoinonly.bin"
   bld_files["core/v2.4.1"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.4.1"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.4.1"]=0

dock_bld_ver["core/v2.4.0"]="core/v2.4.0"
ctnr_src_ver["core/v2.4.0"]="core/v2.4.0"
     bld_opt["core/v2.4.0"]="--skip-legacy"
   prd_files["core/v2.4.0"]="2/trezor-2.4.0.bin 2/trezor-2.4.0-bitcoinonly.bin"
   bld_files["core/v2.4.0"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.4.0"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.4.0"]=0

dock_bld_ver["core/v2.3.6"]="core/v2.3.6"
ctnr_src_ver["core/v2.3.6"]="core/v2.3.6"
     bld_opt["core/v2.3.6"]="--skip-legacy"
   prd_files["core/v2.3.6"]="2/trezor-2.3.6.bin 2/trezor-2.3.6-bitcoinonly.bin"
   bld_files["core/v2.3.6"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.3.6"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.3.6"]=0

dock_bld_ver["core/v2.3.5"]="core/v2.3.5"
ctnr_src_ver["core/v2.3.5"]="core/v2.3.5"
     bld_opt["core/v2.3.5"]="--skip-legacy"
   prd_files["core/v2.3.5"]="2/trezor-2.3.5.bin 2/trezor-2.3.5-bitcoinonly.bin"
   bld_files["core/v2.3.5"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.3.5"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.3.5"]=0

dock_bld_ver["core/v2.3.4"]="core/v2.3.4"
ctnr_src_ver["core/v2.3.4"]="core/v2.3.4"
     bld_opt["core/v2.3.4"]="--skip-legacy"
   prd_files["core/v2.3.4"]="2/trezor-2.3.4.bin 2/trezor-2.3.4-bitcoinonly.bin"
   bld_files["core/v2.3.4"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.3.4"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.3.4"]=0

dock_bld_ver["core/v2.3.3"]="core/v2.3.3"
ctnr_src_ver["core/v2.3.3"]="core/v2.3.3"
     bld_opt["core/v2.3.3"]="--skip-legacy"
   prd_files["core/v2.3.3"]="2/trezor-2.3.3.bin 2/trezor-2.3.3-bitcoinonly.bin"
   bld_files["core/v2.3.3"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.3.3"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.3.3"]=0

dock_bld_ver["core/v2.3.2"]="core/v2.3.2"
ctnr_src_ver["core/v2.3.2"]="core/v2.3.2"
     bld_opt["core/v2.3.2"]="--skip-legacy"
   prd_files["core/v2.3.2"]="2/trezor-2.3.2.bin 2/trezor-2.3.2-bitcoinonly.bin"
   bld_files["core/v2.3.2"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.3.2"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.3.2"]=0

dock_bld_ver["core/v2.3.1"]="core/v2.3.1"
ctnr_src_ver["core/v2.3.1"]="core/v2.3.1"
     bld_opt["core/v2.3.1"]="--skip-legacy"
   prd_files["core/v2.3.1"]="2/trezor-2.3.1.bin 2/trezor-2.3.1-bitcoinonly.bin"
   bld_files["core/v2.3.1"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.3.1"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.3.1"]=0

dock_bld_ver["core/v2.3.0"]="core/v2.3.0"
ctnr_src_ver["core/v2.3.0"]="core/v2.3.0"
     bld_opt["core/v2.3.0"]="--skip-legacy"
   prd_files["core/v2.3.0"]="2/trezor-2.3.0.bin 2/trezor-2.3.0-bitcoinonly.bin"
   bld_files["core/v2.3.0"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.3.0"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.3.0"]=0

dock_bld_ver["core/v2.2.0"]="core/v2.2.0"
ctnr_src_ver["core/v2.2.0"]="core/v2.2.0"
     bld_opt["core/v2.2.0"]="--skip-legacy"
   prd_files["core/v2.2.0"]="2/trezor-2.2.0.bin 2/trezor-2.2.0-bitcoinonly.bin"
   bld_files["core/v2.2.0"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.2.0"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.2.0"]=0

dock_bld_ver["core/v2.1.8"]="core/v2.1.8"
ctnr_src_ver["core/v2.1.8"]="core/v2.1.8"
     bld_opt["core/v2.1.8"]="--skip-legacy"
   prd_files["core/v2.1.8"]="2/trezor-2.1.8.bin 2/trezor-2.1.8-bitcoinonly.bin"
   bld_files["core/v2.1.8"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.1.8"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.1.8"]=0

dock_bld_ver["core/v2.1.7"]="core/v2.1.7"
ctnr_src_ver["core/v2.1.7"]="core/v2.1.7"
     bld_opt["core/v2.1.7"]="--skip-legacy"
   prd_files["core/v2.1.7"]="2/trezor-2.1.7.bin 2/trezor-2.1.7-bitcoinonly.bin"
   bld_files["core/v2.1.7"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.1.7"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.1.7"]=0

dock_bld_ver["core/v2.1.6"]="core/v2.1.6"
ctnr_src_ver["core/v2.1.6"]="core/v2.1.6"
     bld_opt["core/v2.1.6"]="--skip-legacy"
   prd_files["core/v2.1.6"]="2/trezor-2.1.6.bin 2/trezor-2.1.6-bitcoinonly.bin"
   bld_files["core/v2.1.6"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.1.6"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.1.6"]=0

dock_bld_ver["core/v2.1.5"]="core/v2.1.5"
ctnr_src_ver["core/v2.1.5"]="core/v2.1.5"
     bld_opt["core/v2.1.5"]="--skip-legacy"
   prd_files["core/v2.1.5"]="2/trezor-2.1.5.bin 2/trezor-2.1.5-bitcoinonly.bin"
   bld_files["core/v2.1.5"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.1.5"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.1.5"]=0

dock_bld_ver["core/v2.1.4"]="core/v2.1.4"
ctnr_src_ver["core/v2.1.4"]="core/v2.1.4"
     bld_opt["core/v2.1.4"]="--skip-legacy"
   prd_files["core/v2.1.4"]="2/trezor-2.1.4.bin 2/trezor-2.1.4-bitcoinonly.bin"
   bld_files["core/v2.1.4"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.1.4"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.1.4"]=0

dock_bld_ver["core/v2.1.3"]="core/v2.1.3"
ctnr_src_ver["core/v2.1.3"]="core/v2.1.3"
     bld_opt["core/v2.1.3"]="--skip-legacy"
   prd_files["core/v2.1.3"]="2/trezor-2.1.3.bin 2/trezor-2.1.3-bitcoinonly.bin"
   bld_files["core/v2.1.3"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.1.3"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.1.3"]=0

dock_bld_ver["core/v2.1.2"]="core/v2.1.2"
ctnr_src_ver["core/v2.1.2"]="core/v2.1.2"
     bld_opt["core/v2.1.2"]="--skip-legacy"
   prd_files["core/v2.1.2"]="2/trezor-2.1.2.bin 2/trezor-2.1.2-bitcoinonly.bin"
   bld_files["core/v2.1.2"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.1.2"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.1.2"]=0

dock_bld_ver["core/v2.1.1"]="core/v2.1.1"
ctnr_src_ver["core/v2.1.1"]="core/v2.1.1"
     bld_opt["core/v2.1.1"]="--skip-legacy"
   prd_files["core/v2.1.1"]="2/trezor-2.1.1.bin 2/trezor-2.1.1-bitcoinonly.bin"
   bld_files["core/v2.1.1"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.1.1"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.1.1"]=0

dock_bld_ver["core/v2.1.0"]="core/v2.1.0"
ctnr_src_ver["core/v2.1.0"]="core/v2.1.0"
     bld_opt["core/v2.1.0"]="--skip-legacy"
   prd_files["core/v2.1.0"]="2/trezor-2.1.0.bin 2/trezor-2.1.0-bitcoinonly.bin"
   bld_files["core/v2.1.0"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.1.0"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.1.0"]=0

dock_bld_ver["core/v2.0.10"]="core/v2.0.10"
ctnr_src_ver["core/v2.0.10"]="core/v2.0.10"
     bld_opt["core/v2.0.10"]="--skip-legacy"
   prd_files["core/v2.0.10"]="2/trezor-2.0.10.bin 2/trezor-2.0.10-bitcoinonly.bin"
   bld_files["core/v2.0.10"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.0.10"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.0.10"]=0

dock_bld_ver["core/v2.0.9"]="core/v2.0.9"
ctnr_src_ver["core/v2.0.9"]="core/v2.0.9"
     bld_opt["core/v2.0.9"]="--skip-legacy"
   prd_files["core/v2.0.9"]="2/trezor-2.0.9.bin 2/trezor-2.0.9-bitcoinonly.bin"
   bld_files["core/v2.0.9"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.0.9"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.0.9"]=0

dock_bld_ver["core/v2.0.8"]="core/v2.0.8"
ctnr_src_ver["core/v2.0.8"]="core/v2.0.8"
     bld_opt["core/v2.0.8"]="--skip-legacy"
   prd_files["core/v2.0.8"]="2/trezor-2.0.8.bin 2/trezor-2.0.8-bitcoinonly.bin"
   bld_files["core/v2.0.8"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.0.8"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.0.8"]=0

dock_bld_ver["core/v2.0.7"]="core/v2.0.7"
ctnr_src_ver["core/v2.0.7"]="core/v2.0.7"
     bld_opt["core/v2.0.7"]="--skip-legacy"
   prd_files["core/v2.0.7"]="2/trezor-2.0.7.bin 2/trezor-2.0.7-bitcoinonly.bin"
   bld_files["core/v2.0.7"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.0.7"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.0.7"]=0

dock_bld_ver["core/v2.0.6"]="core/v2.0.6"
ctnr_src_ver["core/v2.0.6"]="core/v2.0.6"
     bld_opt["core/v2.0.6"]="--skip-legacy"
   prd_files["core/v2.0.6"]="2/trezor-2.0.6.bin 2/trezor-2.0.6-bitcoinonly.bin"
   bld_files["core/v2.0.6"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.0.6"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.0.6"]=0

dock_bld_ver["core/v2.0.5"]="core/v2.0.5"
ctnr_src_ver["core/v2.0.5"]="core/v2.0.5"
     bld_opt["core/v2.0.5"]="--skip-legacy"
   prd_files["core/v2.0.5"]="2/trezor-2.0.5.bin 2/trezor-2.0.5-bitcoinonly.bin"
   bld_files["core/v2.0.5"]="${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["core/v2.0.5"]="bs=1 seek=5567 count=65 conv=notrunc status=none"
  is_hash_eq["core/v2.0.5"]=0

dock_bld_ver["legacy/v1.12.1"]="legacy/v1.12.1"
ctnr_src_ver["legacy/v1.12.1"]="legacy/v1.12.1"
     bld_opt["legacy/v1.12.1"]="--skip-core"
   prd_files["legacy/v1.12.1"]="1/trezor-1.12.1.bin 1/trezor-1.12.1-bitcoinonly.bin"
   bld_files["legacy/v1.12.1"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.12.1"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.12.1"]=1

dock_bld_ver["legacy/v1.12.0"]="legacy/v1.12.0"
ctnr_src_ver["legacy/v1.12.0"]="legacy/v1.12.0"
     bld_opt["legacy/v1.12.0"]="--skip-core"
   prd_files["legacy/v1.12.0"]="1/trezor-1.12.0.bin 1/trezor-1.12.0-bitcoinonly.bin"
   bld_files["legacy/v1.12.0"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.12.0"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.12.0"]=0

dock_bld_ver["legacy/v1.11.2"]="legacy/v1.11.2"
ctnr_src_ver["legacy/v1.11.2"]="legacy/v1.11.2"
     bld_opt["legacy/v1.11.2"]="--skip-core"
   prd_files["legacy/v1.11.2"]="1/trezor-1.11.2.bin 1/trezor-1.11.2-bitcoinonly.bin"
   bld_files["legacy/v1.11.2"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.11.2"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.11.2"]=1

dock_bld_ver["legacy/v1.11.1"]="legacy/v1.11.1"
ctnr_src_ver["legacy/v1.11.1"]="legacy/v1.11.1"
     bld_opt["legacy/v1.11.1"]="--skip-core"
   prd_files["legacy/v1.11.1"]="1/trezor-1.11.1.bin 1/trezor-1.11.1-bitcoinonly.bin"
   bld_files["legacy/v1.11.1"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.11.1"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.11.1"]=0

dock_bld_ver["legacy/v1.10.5"]="legacy/v1.10.5"
ctnr_src_ver["legacy/v1.10.5"]="legacy/v1.10.5"
     bld_opt["legacy/v1.10.5"]="--skip-core"
   prd_files["legacy/v1.10.5"]="1/trezor-1.10.5.bin 1/trezor-1.10.5-bitcoinonly.bin"
   bld_files["legacy/v1.10.5"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.10.5"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.10.5"]=0

dock_bld_ver["legacy/v1.10.4"]="legacy/v1.10.4"
ctnr_src_ver["legacy/v1.10.4"]="legacy/v1.10.4"
     bld_opt["legacy/v1.10.4"]="--skip-core"
   prd_files["legacy/v1.10.4"]="1/trezor-1.10.4.bin 1/trezor-1.10.4-bitcoinonly.bin"
   bld_files["legacy/v1.10.4"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.10.4"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.10.4"]=0

dock_bld_ver["legacy/v1.10.3"]="legacy/v1.10.3"
ctnr_src_ver["legacy/v1.10.3"]="legacy/v1.10.3"
     bld_opt["legacy/v1.10.3"]="--skip-core"
   prd_files["legacy/v1.10.3"]="1/trezor-1.10.3.bin 1/trezor-1.10.3-bitcoinonly.bin"
   bld_files["legacy/v1.10.3"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.10.3"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.10.3"]=0

dock_bld_ver["legacy/v1.10.2"]="legacy/v1.10.2"
ctnr_src_ver["legacy/v1.10.2"]="legacy/v1.10.2"
     bld_opt["legacy/v1.10.2"]="--skip-core"
   prd_files["legacy/v1.10.2"]="1/trezor-1.10.2.bin 1/trezor-1.10.2-bitcoinonly.bin"
   bld_files["legacy/v1.10.2"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.10.2"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.10.2"]=0

dock_bld_ver["legacy/v1.10.1"]="legacy/v1.10.1"
ctnr_src_ver["legacy/v1.10.1"]="legacy/v1.10.1"
     bld_opt["legacy/v1.10.1"]="--skip-core"
   prd_files["legacy/v1.10.1"]="1/trezor-1.10.1.bin 1/trezor-1.10.1-bitcoinonly.bin"
   bld_files["legacy/v1.10.1"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.10.1"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.10.1"]=0

dock_bld_ver["legacy/v1.10.0"]="legacy/v1.10.0"
ctnr_src_ver["legacy/v1.10.0"]="legacy/v1.10.0"
     bld_opt["legacy/v1.10.0"]="--skip-core"
   prd_files["legacy/v1.10.0"]="1/trezor-1.10.0.bin 1/trezor-1.10.0-bitcoinonly.bin"
   bld_files["legacy/v1.10.0"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.10.0"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.10.0"]=0

dock_bld_ver["legacy/v1.9.4"]="legacy/v1.9.4"
ctnr_src_ver["legacy/v1.9.4"]="legacy/v1.9.4"
     bld_opt["legacy/v1.9.4"]="--skip-core"
   prd_files["legacy/v1.9.4"]="1/trezor-1.9.4.bin 1/trezor-1.9.4-bitcoinonly.bin"
   bld_files["legacy/v1.9.4"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.9.4"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.9.4"]=0

dock_bld_ver["legacy/v1.9.3"]="legacy/v1.9.3"
ctnr_src_ver["legacy/v1.9.3"]="legacy/v1.9.3"
     bld_opt["legacy/v1.9.3"]="--skip-core"
   prd_files["legacy/v1.9.3"]="1/trezor-1.9.3.bin 1/trezor-1.9.3-bitcoinonly.bin"
   bld_files["legacy/v1.9.3"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.9.3"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.9.3"]=0

dock_bld_ver["legacy/v1.9.2"]="legacy/v1.9.2"
ctnr_src_ver["legacy/v1.9.2"]="legacy/v1.9.2"
     bld_opt["legacy/v1.9.2"]="--skip-core"
   prd_files["legacy/v1.9.2"]="1/trezor-1.9.2.bin 1/trezor-1.9.2-bitcoinonly.bin"
   bld_files["legacy/v1.9.2"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.9.2"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.9.2"]=0

dock_bld_ver["legacy/v1.9.1"]="legacy/v1.9.1"
ctnr_src_ver["legacy/v1.9.1"]="legacy/v1.9.1"
     bld_opt["legacy/v1.9.1"]="--skip-core"
   prd_files["legacy/v1.9.1"]="1/trezor-1.9.1.bin 1/trezor-1.9.1-bitcoinonly.bin"
   bld_files["legacy/v1.9.1"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.9.1"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.9.1"]=0

dock_bld_ver["legacy/v1.9.0"]="legacy/v1.9.0"
ctnr_src_ver["legacy/v1.9.0"]="legacy/v1.9.0"
     bld_opt["legacy/v1.9.0"]="--skip-core"
   prd_files["legacy/v1.9.0"]="1/trezor-1.9.0.bin 1/trezor-1.9.0-bitcoinonly.bin"
   bld_files["legacy/v1.9.0"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.9.0"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.9.0"]=0

dock_bld_ver["legacy/v1.8.3"]="legacy/v1.8.3"
ctnr_src_ver["legacy/v1.8.3"]="legacy/v1.8.3"
     bld_opt["legacy/v1.8.3"]="--skip-core"
   prd_files["legacy/v1.8.3"]="1/trezor-1.8.3.bin 1/trezor-1.8.3-bitcoinonly.bin"
   bld_files["legacy/v1.8.3"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.8.3"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.8.3"]=0

dock_bld_ver["legacy/v1.8.2"]="legacy/v1.8.2"
ctnr_src_ver["legacy/v1.8.2"]="legacy/v1.8.2"
     bld_opt["legacy/v1.8.2"]="--skip-core"
   prd_files["legacy/v1.8.2"]="1/trezor-1.8.2.bin 1/trezor-1.8.2-bitcoinonly.bin"
   bld_files["legacy/v1.8.2"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.8.2"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.8.2"]=0

dock_bld_ver["legacy/v1.8.1"]="legacy/v1.8.1"
ctnr_src_ver["legacy/v1.8.1"]="legacy/v1.8.1"
     bld_opt["legacy/v1.8.1"]="--skip-core"
   prd_files["legacy/v1.8.1"]="1/trezor-1.8.1.bin 1/trezor-1.8.1-bitcoinonly.bin"
   bld_files["legacy/v1.8.1"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.8.1"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.8.1"]=0

dock_bld_ver["legacy/v1.8.0"]="legacy/v1.8.0"
ctnr_src_ver["legacy/v1.8.0"]="legacy/v1.8.0"
     bld_opt["legacy/v1.8.0"]="--skip-core"
   prd_files["legacy/v1.8.0"]="1/trezor-1.8.0.bin 1/trezor-1.8.0-bitcoinonly.bin"
   bld_files["legacy/v1.8.0"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.8.0"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.8.0"]=0

dock_bld_ver["legacy/v1.7.3"]="legacy/v1.7.3"
ctnr_src_ver["legacy/v1.7.3"]="legacy/v1.7.3"
     bld_opt["legacy/v1.7.3"]="--skip-core"
   prd_files["legacy/v1.7.3"]="1/trezor-1.7.3.bin 1/trezor-1.7.3-bitcoinonly.bin"
   bld_files["legacy/v1.7.3"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.7.3"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.7.3"]=0

dock_bld_ver["legacy/v1.7.2"]="legacy/v1.7.2"
ctnr_src_ver["legacy/v1.7.2"]="legacy/v1.7.2"
     bld_opt["legacy/v1.7.2"]="--skip-core"
   prd_files["legacy/v1.7.2"]="1/trezor-1.7.2.bin 1/trezor-1.7.2-bitcoinonly.bin"
   bld_files["legacy/v1.7.2"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.7.2"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.7.2"]=0

dock_bld_ver["legacy/v1.7.1"]="legacy/v1.7.1"
ctnr_src_ver["legacy/v1.7.1"]="legacy/v1.7.1"
     bld_opt["legacy/v1.7.1"]="--skip-core"
   prd_files["legacy/v1.7.1"]="1/trezor-1.7.1.bin 1/trezor-1.7.1-bitcoinonly.bin"
   bld_files["legacy/v1.7.1"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.7.1"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.7.1"]=0

dock_bld_ver["legacy/v1.7.0"]="legacy/v1.7.0"
ctnr_src_ver["legacy/v1.7.0"]="legacy/v1.7.0"
     bld_opt["legacy/v1.7.0"]="--skip-core"
   prd_files["legacy/v1.7.0"]="1/trezor-1.7.0.bin 1/trezor-1.7.0-bitcoinonly.bin"
   bld_files["legacy/v1.7.0"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.7.0"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.7.0"]=0

dock_bld_ver["legacy/v1.6.3"]="legacy/v1.6.3"
ctnr_src_ver["legacy/v1.6.3"]="legacy/v1.6.3"
     bld_opt["legacy/v1.6.3"]="--skip-core"
   prd_files["legacy/v1.6.3"]="1/trezor-1.6.3.bin 1/trezor-1.6.3-bitcoinonly.bin"
   bld_files["legacy/v1.6.3"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.6.3"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.6.3"]=0

dock_bld_ver["legacy/v1.6.2"]="legacy/v1.6.2"
ctnr_src_ver["legacy/v1.6.2"]="legacy/v1.6.2"
     bld_opt["legacy/v1.6.2"]="--skip-core"
   prd_files["legacy/v1.6.2"]="1/trezor-1.6.2.bin 1/trezor-1.6.2-bitcoinonly.bin"
   bld_files["legacy/v1.6.2"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.6.2"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.6.2"]=0

dock_bld_ver["legacy/v1.6.1"]="legacy/v1.6.1"
ctnr_src_ver["legacy/v1.6.1"]="legacy/v1.6.1"
     bld_opt["legacy/v1.6.1"]="--skip-core"
   prd_files["legacy/v1.6.1"]="1/trezor-1.6.1.bin 1/trezor-1.6.1-bitcoinonly.bin"
   bld_files["legacy/v1.6.1"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.6.1"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.6.1"]=0

dock_bld_ver["legacy/v1.6.0"]="legacy/v1.6.0"
ctnr_src_ver["legacy/v1.6.0"]="legacy/v1.6.0"
     bld_opt["legacy/v1.6.0"]="--skip-core"
   prd_files["legacy/v1.6.0"]="1/trezor-1.6.0.bin 1/trezor-1.6.0-bitcoinonly.bin"
   bld_files["legacy/v1.6.0"]="${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin"
dd_zero_opts["legacy/v1.6.0"]="bs=1 seek=544 count=195 conv=notrunc status=none"
  is_hash_eq["legacy/v1.6.0"]=0

dock_bld_ver["core/bl2.1.0"]="core/v2.6.0"
ctnr_src_ver["core/bl2.1.0"]="core/bl2.1.0"
 prd_bin_ver["core/bl2.1.0"]="core/v2.6.0"
     bld_opt["core/bl2.1.0"]="--skip-bitcoinonly --skip-legacy"
   prd_files["core/bl2.1.0"]="${EXEC_PATH}/repo/core/embed/firmware/bootloaders/bootloader_T2T1.bin"
   bld_files["core/bl2.1.0"]="${EXEC_PATH}/repo/build/core/bootloader/bootloader.bin"
  is_hash_eq["core/bl2.1.0"]=1

dock_bld_ver["core/bl2.0.3"]="core/bl2.0.3"
ctnr_src_ver["core/bl2.0.3"]="core/bl2.0.3"
 prd_bin_ver["core/bl2.0.3"]="core/bl2.0.3"
     bld_opt["core/bl2.0.3"]="--skip-bitcoinonly --skip-legacy"
   prd_files["core/bl2.0.3"]="${EXEC_PATH}/repo/core/embed/firmware/bootloaders/bootloader_T2T1.bin"
   bld_files["core/bl2.0.3"]="${EXEC_PATH}/repo/build/core/bootloader/bootloader.bin"
  is_hash_eq["core/bl2.0.3"]=0

dock_bld_ver["core/bl2.0.2"]="core/bl2.0.2"
ctnr_src_ver["core/bl2.0.2"]="core/bl2.0.2"
 prd_bin_ver["core/bl2.0.2"]="core/bl2.0.2"
     bld_opt["core/bl2.0.2"]="--skip-bitcoinonly --skip-legacy"
   prd_files["core/bl2.0.2"]="${EXEC_PATH}/repo/core/embed/firmware/bootloaders/bootloader_T2T1.bin"
   bld_files["core/bl2.0.2"]="${EXEC_PATH}/repo/build/core/bootloader/bootloader.bin"
  is_hash_eq["core/bl2.0.2"]=0

dock_bld_ver["core/bl2.0.1"]="core/bl2.0.1"
ctnr_src_ver["core/bl2.0.1"]="core/bl2.0.1"
 prd_bin_ver["core/bl2.0.1"]="core/bl2.0.1"
     bld_opt["core/bl2.0.1"]="--skip-bitcoinonly --skip-legacy"
   prd_files["core/bl2.0.1"]="${EXEC_PATH}/repo/core/embed/firmware/bootloaders/bootloader_T2T1.bin"
   bld_files["core/bl2.0.1"]="${EXEC_PATH}/repo/build/core/bootloader/bootloader.bin"
  is_hash_eq["core/bl2.0.1"]=0

dock_bld_ver["core/bl2.0.0"]="core/bl2.0.0"
ctnr_src_ver["core/bl2.0.0"]="core/bl2.0.0"
 prd_bin_ver["core/bl2.0.0"]="core/bl2.0.0"
     bld_opt["core/bl2.0.0"]="--skip-bitcoinonly --skip-legacy"
   prd_files["core/bl2.0.0"]="${EXEC_PATH}/repo/core/embed/firmware/bootloaders/bootloader_T2T1.bin"
   bld_files["core/bl2.0.0"]="${EXEC_PATH}/repo/build/core/bootloader/bootloader.bin"
  is_hash_eq["core/bl2.0.0"]=0

dock_bld_ver["legacy/bl1.12.1"]="legacy/bl1.12.1"
ctnr_src_ver["legacy/bl1.12.1"]="legacy/bl1.12.1"
 prd_bin_ver["legacy/bl1.12.1"]="legacy/bl1.12.1"
     bld_opt["legacy/bl1.12.1"]="--skip-bitcoinonly --skip-core"
   prd_files["legacy/bl1.12.1"]="${EXEC_PATH}/repo/legacy/firmware/bootloader.dat"
   bld_files["legacy/bl1.12.1"]="${EXEC_PATH}/repo/build/legacy/bootloader/bootloader.bin"
  is_hash_eq["legacy/bl1.12.1"]=1

dock_bld_ver["legacy/bl1.12.0"]="legacy/bl1.12.0"
ctnr_src_ver["legacy/bl1.12.0"]="legacy/bl1.12.0"
 prd_bin_ver["legacy/bl1.12.0"]="legacy/bl1.12.0"
     bld_opt["legacy/bl1.12.0"]="--skip-bitcoinonly --skip-core"
   prd_files["legacy/bl1.12.0"]="${EXEC_PATH}/repo/legacy/firmware/bootloader.dat"
   bld_files["legacy/bl1.12.0"]="${EXEC_PATH}/repo/build/legacy/bootloader/bootloader.bin"
  is_hash_eq["legacy/bl1.12.0"]=0

dock_bld_ver["legacy/bl1.11.0"]="legacy/bl1.11.0"
ctnr_src_ver["legacy/bl1.11.0"]="legacy/bl1.11.0"
 prd_bin_ver["legacy/bl1.11.0"]="legacy/bl1.11.0"
     bld_opt["legacy/bl1.11.0"]="--skip-core --skip-bitcoinonly"
   prd_files["legacy/bl1.11.0"]="${EXEC_PATH}/repo/legacy/firmware/bootloader.dat"
   bld_files["legacy/bl1.11.0"]="${EXEC_PATH}/repo/build/legacy/bootloader/bootloader.bin"
  is_hash_eq["legacy/bl1.11.0"]=0

dock_bld_ver["legacy/bl1.8.0"]="legacy/bl1.8.0"
ctnr_src_ver["legacy/bl1.8.0"]="legacy/bl1.8.0"
 prd_bin_ver["legacy/bl1.8.0"]="legacy/bl1.8.0"
     bld_opt["legacy/bl1.8.0"]="--skip-bitcoinonly --skip-core"
   prd_files["legacy/bl1.8.0"]="${EXEC_PATH}/repo/legacy/firmware/bootloader.dat"
   bld_files["legacy/bl1.8.0"]="${EXEC_PATH}/repo/build/legacy/bootloader/bootloader.bin"
  is_hash_eq["legacy/bl1.8.0"]=0

dock_bld_ver["legacy/bl1.6.1"]="legacy/bl1.6.1"
ctnr_src_ver["legacy/bl1.6.1"]="legacy/bl1.6.1"
 prd_bin_ver["legacy/bl1.6.1"]="legacy/bl1.6.1"
     bld_opt["legacy/bl1.6.1"]="--skip-bitcoinonly --skip-core"
   prd_files["legacy/bl1.6.1"]="${EXEC_PATH}/repo/legacy/firmware/bootloader.dat"
   bld_files["legacy/bl1.6.1"]="${EXEC_PATH}/repo/build/legacy/bootloader/bootloader.bin"
  is_hash_eq["legacy/bl1.6.1"]=0

dock_bld_ver["legacy/bl1.6.0"]="legacy/bl1.6.0"
ctnr_src_ver["legacy/bl1.6.0"]="legacy/bl1.6.0"
 prd_bin_ver["legacy/bl1.6.0"]="legacy/bl1.6.0"
     bld_opt["legacy/bl1.6.0"]="--skip-bitcoinonly --skip-core"
   prd_files["legacy/bl1.6.0"]="${EXEC_PATH}/repo/legacy/firmware/bootloader.dat"
   bld_files["legacy/bl1.6.0"]="${EXEC_PATH}/repo/build/legacy/bootloader/bootloader.bin"
  is_hash_eq["legacy/bl1.6.0"]=0

dock_bld_ver["legacy/bl1.5.1"]="legacy/bl1.5.1"
ctnr_src_ver["legacy/bl1.5.1"]="legacy/bl1.5.1"
 prd_bin_ver["legacy/bl1.5.1"]="legacy/bl1.5.1"
     bld_opt["legacy/bl1.5.1"]="--skip-bitcoinonly --skip-core"
   prd_files["legacy/bl1.5.1"]="${EXEC_PATH}/repo/legacy/firmware/bootloader.dat"
   bld_files["legacy/bl1.5.1"]="${EXEC_PATH}/repo/build/legacy/bootloader/bootloader.bin"
  is_hash_eq["legacy/bl1.5.1"]=0

dock_bld_ver["legacy/bl1.5.0"]="legacy/bl1.5.0"
ctnr_src_ver["legacy/bl1.5.0"]="legacy/bl1.5.0"
 prd_bin_ver["legacy/bl1.5.0"]="legacy/bl1.5.0"
     bld_opt["legacy/bl1.5.0"]="--skip-bitcoinonly --skip-core"
   prd_files["legacy/bl1.5.0"]="${EXEC_PATH}/repo/legacy/firmware/bootloader.dat"
   bld_files["legacy/bl1.5.0"]="${EXEC_PATH}/repo/build/legacy/bootloader/bootloader.bin"
  is_hash_eq["legacy/bl1.5.0"]=0

dock_bld_ver["legacy/bl1.4.0"]="legacy/bl1.4.0"
ctnr_src_ver["legacy/bl1.4.0"]="legacy/bl1.4.0"
 prd_bin_ver["legacy/bl1.4.0"]="legacy/bl1.4.0"
     bld_opt["legacy/bl1.4.0"]="--skip-bitcoinonly --skip-core"
   prd_files["legacy/bl1.4.0"]="${EXEC_PATH}/repo/legacy/firmware/bootloader.dat"
   bld_files["legacy/bl1.4.0"]="${EXEC_PATH}/repo/build/legacy/bootloader/bootloader.bin"
  is_hash_eq["legacy/bl1.4.0"]=0

