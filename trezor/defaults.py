#!/bin/env python3
# [rights]  Copyright 2023 brianddk at github https://github.com/brianddk
# [license] Apache 2.0 License https://www.apache.org/licenses/LICENSE-2.0
# [repo]    github.com/brianddk/attestation/
# [btc]     BTC-b32: bc1qwc2203uym96u0nmq04pcgqfs9ldqz9l3mz8fpj
# [tipjar]  github.com/brianddk/reddit/blob/master/tipjar/tipjar.txt
# [req]     python3
# [note]    This script is a maker program for the settings.sh file.  You can
# [note]      run this script then compare the output to the contents of
# [note]      settings.sh to determine what's changed


def gen_defaults():
    for tag in core_fw.splitlines():
        tag = tag.strip()
        ver = tag[6:] # core/v
        dflt = default['core']['fw']
        if "" == tag:
            continue
        else:
            print('dock_bld_ver["{}"]="{}"'.format(tag, dflt['dock_bld_ver'].format(tag)))
            print('ctnr_src_ver["{}"]="{}"'.format(tag, dflt['ctnr_src_ver'].format(tag)))
            print('     bld_opt["{}"]="{}"'.format(tag, dflt['bld_opt']))
            print('   prd_files["{}"]="{}"'.format(tag, dflt['prd_files'].format(ver, ver)))
            print('   bld_files["{}"]="{}"'.format(tag, dflt['bld_files']))
            print('dd_zero_opts["{}"]="{}"'.format(tag, dflt['dd_zero_opts']))
            print('  is_hash_eq["{}"]=0'.format(tag))

        print("")

    for tag in legacy_fw.splitlines():
        tag = tag.strip()
        ver = tag[8:] # legacy/v
        dflt = default['legacy']['fw']
        if "" == tag:
            continue
        else:
            print('dock_bld_ver["{}"]="{}"'.format(tag, dflt['dock_bld_ver'].format(tag)))
            print('ctnr_src_ver["{}"]="{}"'.format(tag, dflt['ctnr_src_ver'].format(tag)))
            print('     bld_opt["{}"]="{}"'.format(tag, dflt['bld_opt']))
            print('   prd_files["{}"]="{}"'.format(tag, dflt['prd_files'].format(ver, ver)))
            print('   bld_files["{}"]="{}"'.format(tag, dflt['bld_files']))
            print('dd_zero_opts["{}"]="{}"'.format(tag, dflt['dd_zero_opts']))
            print('  is_hash_eq["{}"]=0'.format(tag))

        print("")

    for tag in core_bl.splitlines():
        tag = tag.strip()
        ver = tag[7:] # core/bl
        dflt = default['core']['bl']
        if "" == tag:
            continue
        else:
            print('dock_bld_ver["{}"]="{}"'.format(tag, dflt['dock_bld_ver'].format(tag)))
            print('ctnr_src_ver["{}"]="{}"'.format(tag, dflt['ctnr_src_ver'].format(tag)))
            print(' prd_bin_ver["{}"]="{}"'.format(tag, dflt['prd_bin_ver'].format(tag)))
            print('     bld_opt["{}"]="{}"'.format(tag, dflt['bld_opt']))
            print('   prd_files["{}"]="{}"'.format(tag, dflt['prd_files']))
            print('   bld_files["{}"]="{}"'.format(tag, dflt['bld_files']))
            print('  is_hash_eq["{}"]=0'.format(tag))

        print("")

    for tag in legacy_bl.splitlines():
        tag = tag.strip()
        ver = tag[9:] # legacy/bl
        dflt = default['legacy']['bl']
        if "" == tag:
            continue
        else:
            print('dock_bld_ver["{}"]="{}"'.format(tag, dflt['dock_bld_ver'].format(tag)))
            print('ctnr_src_ver["{}"]="{}"'.format(tag, dflt['ctnr_src_ver'].format(tag)))
            print(' prd_bin_ver["{}"]="{}"'.format(tag, dflt['prd_bin_ver'].format(tag)))
            print('     bld_opt["{}"]="{}"'.format(tag, dflt['bld_opt']))
            print('   prd_files["{}"]="{}"'.format(tag, dflt['prd_files']))
            print('   bld_files["{}"]="{}"'.format(tag, dflt['bld_files']))
            print('  is_hash_eq["{}"]=0'.format(tag))

        print("")


def mk_header():
    msg='''#!/bin/bash
# [rights]  Copyright 2023 brianddk at github https://github.com/brianddk
# [license] Apache 2.0 License https://www.apache.org/licenses/LICENSE-2.0
# [repo]    github.com/brianddk/attestation/
# [btc]     BTC-b32: bc1qwc2203uym96u0nmq04pcgqfs9ldqz9l3mz8fpj
# [tipjar]  github.com/brianddk/reddit/blob/master/tipjar/tipjar.txt
# [req]     bash
# [note]    This script is intended to be sourced from verify.sh.  It serves
# [note]      as a global settings data structure to do all the builds that
# [note]      have source tags in Trezor's github


# This test script requires BASH 2.0 or later 
_bash_major_version=${BASH_VERSION::1}
_ostype="Linux"
_realpath="realpath"

# Must run BASH 4.0 or greater for associative arrays
if [ $_bash_major_version -lt 4 ]; then
  echo "ERROR: Need Bash version 4 or greater.  Found version ${BASH_VERSION}"
  exit 1

# Darwin's realpath doesn't support --relative-to, need grealpath
elif [[ "$(uname -s)" == "Darwin" ]]; then
  _ostype="Darwin"
  _realpath="grealpath"
  
# Test if we are in WSL, for completeness
elif [[ ! -z $WSL_DISTRO_NAME ]]; then
  _ostype="Windows"    
fi
# Now it is assumed that we are at BASH v4.0 or higher

if command -v sha256sum; then
  _sha256sum="sha256sum"
elif command -v shasum
  _sha256sum="shasum -a 256"
else
  echo "sha256sum or shasum required for this script"
  exit 2
fi

if command -v gpg2; then
  _gpg="gpg2"
else
  _gpg="gpg"
fi

for i in $_realpath wget awk docker git wget dd tail dirname basename find $_gpg; do
  command -v $i || echo "Ensure $i is installed" || exit 3
done

EXEC_PATH=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
REAL_PATH=$($_realpath --relative-to="$PWD" "${EXEC_PATH}")
if [[ -z "${REAL_PATH}" ]]; then
  REAL_PATH=.
fi

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
# Any notes that should be included in the attestation
declare -A         note
# Older builds have a different build-docker.sh location
declare -A  dock_bld_sh
'''
    print(msg)


default = {
    'core' : {
        'bl' : {
            'dock_bld_ver' : "{}",
            'ctnr_src_ver' : "{}",
            'prd_bin_ver' :  "{}",
            'bld_opt' :      "--skip-bitcoinonly --skip-legacy",
            'prd_files' :    "${EXEC_PATH}/repo/core/embed/firmware/bootloaders/bootloader_T2T1.bin",
            'bld_files' :    "${EXEC_PATH}/repo/build/core/bootloader/bootloader.bin",
            'is_hash_eq' :   0
        },
        'fw' : {
            'dock_bld_ver' : "{}",
            'ctnr_src_ver' : "{}",
            'bld_opt' :      "--skip-legacy",
            'prd_files' :    "2/trezor-{}.bin 2/trezor-{}-bitcoinonly.bin",
            'bld_files' :    "${EXEC_PATH}/repo/build/core/firmware/firmware.bin ${EXEC_PATH}/repo/build/core-bitcoinonly/firmware/firmware.bin",
            'dd_zero_opts' : "bs=1 seek=5567 count=65 conv=notrunc status=none",
            'is_hash_eq' :   0
        }
    },
    'legacy' : {
        'bl' : {
            'dock_bld_ver' : "{}",
            'ctnr_src_ver' : "{}",
            'prd_bin_ver' :  "{}",
            'bld_opt' :      "--skip-bitcoinonly --skip-core",
            'prd_files' :    "${EXEC_PATH}/repo/legacy/firmware/bootloader.dat",
            'bld_files' :    "${EXEC_PATH}/repo/build/legacy/bootloader/bootloader.bin",
            'is_hash_eq' :   0
        },
        'fw' : {
            'dock_bld_ver' : "{}",
            'ctnr_src_ver' : "{}",
            'bld_opt' :      "--skip-core",
            'prd_files' :    "1/trezor-{}.bin 1/trezor-{}-bitcoinonly.bin",
            'bld_files' :    "${EXEC_PATH}/repo/build/legacy/firmware/firmware.bin ${EXEC_PATH}/repo/build/legacy-bitcoinonly/firmware/firmware.bin",
            'dd_zero_opts' : "bs=1 seek=544 count=195 conv=notrunc status=none",
            'is_hash_eq' :   0
        }
    }
}


keys_bl="""
dock_bld_ver
ctnr_src_ver
prd_bin_ver
bld_opt
prd_files
bld_files
is_hash_eq
"""


keys_fw="""
dock_bld_ver
ctnr_src_ver
bld_opt
prd_files
bld_files
dd_zero_opts
is_hash_eq
"""


legacy_bl="""
legacy/bl1.12.1
legacy/bl1.12.0
legacy/bl1.11.0
legacy/bl1.8.0
legacy/bl1.6.1
legacy/bl1.6.0
legacy/bl1.5.1
legacy/bl1.5.0
legacy/bl1.4.0
"""


core_bl="""
core/bl2.1.0
core/bl2.0.3
core/bl2.0.2
core/bl2.0.1
core/bl2.0.0
"""


legacy_fw="""
legacy/v1.12.1
legacy/v1.12.0
legacy/v1.11.2
legacy/v1.11.1
legacy/v1.10.5
legacy/v1.10.4
legacy/v1.10.3
legacy/v1.10.2
legacy/v1.10.1
legacy/v1.10.0
legacy/v1.9.4
legacy/v1.9.3
legacy/v1.9.2
legacy/v1.9.1
legacy/v1.9.0
legacy/v1.8.3
legacy/v1.8.2
legacy/v1.8.1
legacy/v1.8.0
legacy/v1.7.3
legacy/v1.7.2
legacy/v1.7.1
legacy/v1.7.0
legacy/v1.6.3
legacy/v1.6.2
legacy/v1.6.1
legacy/v1.6.0
"""


core_fw="""
core/v2.6.0
core/v2.5.3
core/v2.5.2
core/v2.5.1
core/v2.4.3
core/v2.4.2
core/v2.4.1
core/v2.4.0
core/v2.3.6
core/v2.3.5
core/v2.3.4
core/v2.3.3
core/v2.3.2
core/v2.3.1
core/v2.3.0
core/v2.2.0
core/v2.1.8
core/v2.1.7
core/v2.1.6
core/v2.1.5
core/v2.1.4
core/v2.1.3
core/v2.1.2
core/v2.1.1
core/v2.1.0
core/v2.0.10
core/v2.0.9
core/v2.0.8
core/v2.0.7
core/v2.0.6
core/v2.0.5
"""


if __name__ == "__main__":
    mk_header()
    gen_defaults()


'''
### List all non-hex, relevant tags by date.

"--skip-bitcoinonly --skip-core" # b-core mode

2023-04-27 13:37:16 +0200 python/v0.13.6
2023-04-07 20:22:17 +0200 core/v2.6.0
2023-04-05 23:38:41 +0200 core/bl2.1.0
2023-03-02 20:39:42 +0100 legacy/v1.12.1
2023-02-27 14:54:17 +0100 legacy/bl1.12.1
2023-01-02 11:37:56 +0100 legacy/v1.12.0
2023-01-02 11:37:56 +0100 legacy/bl1.12.0
2022-12-28 16:21:23 +0100 python/v0.13.5
2022-11-04 10:12:32 +0100 python/v0.13.4
2022-11-02 14:59:22 +0100 core/v2.5.3
2022-08-02 22:26:27 +0200 legacy/v1.11.2
2022-08-02 22:26:27 +0200 core/v2.5.2
2022-07-13 15:15:26 +0200 python/v0.13.3
2022-06-30 15:56:12 +0200 python/v0.13.2
2022-06-29 14:35:16 +0200 python/v0.13.1
2022-05-03 23:00:25 +0200 legacy/v1.11.1
2022-05-03 23:00:25 +0200 core/v2.5.1
2022-05-02 15:02:02 +0200 legacy/bl1.11.0

"--skip-core --skip-bitcoinonly" # core-b mode

2021-12-28 12:42:43 +0100 legacy/v1.10.5
2021-12-09 14:32:43 +0100 python/v0.13.0
2021-11-23 14:57:25 +0100 legacy/v1.10.4
2021-11-23 14:57:25 +0100 core/v2.4.3
2021-09-07 12:35:42 +0200 python/v0.12.4
2021-08-27 13:40:20 +0200 legacy/v1.10.3
2021-08-27 13:40:20 +0200 core/v2.4.2
2021-07-29 15:12:55 +0200 python/v0.12.3
2021-07-13 17:24:16 +0200 legacy/v1.10.2
2021-07-13 17:24:16 +0200 core/v2.4.1
2021-06-03 16:56:20 +0200 core/v2.4.0
2021-06-01 14:08:30 +0200 legacy/v1.10.1

"" # No Args

2021-04-21 16:00:49 +0200 legacy/v1.10.0
2021-02-13 11:10:17 +0100 core/v2.3.6
2021-01-27 18:28:10 +0100 legacy/v1.9.4
2021-01-27 18:28:10 +0100 core/v2.3.5

# stm32lib submodule failure

2020-09-28 16:12:52 +0200 core/v2.3.4
2020-09-01 15:56:57 +0200 legacy/v1.9.3
2020-09-01 15:56:57 +0200 core/v2.3.3
2020-08-27 15:24:32 +0200 python/v0.12.2
2020-08-05 17:10:46 +0200 core/v2.3.2
2020-08-05 16:45:56 +0200 python/v0.12.1
2020-08-05 12:03:37 +0200 legacy/v1.9.2

# Docker to Debian 10

2020-06-02 11:25:29 +0200 legacy/v1.9.1
2020-06-02 11:25:29 +0200 core/v2.3.1
2020-04-01 12:13:16 +0200 python/v0.12.0
2020-03-30 16:04:05 +0000 legacy/v1.9.0
2020-03-30 16:04:05 +0000 core/v2.3.0
2019-12-30 13:03:36 +0100 python/v0.11.6
2019-12-19 17:37:49 +0000 core/v2.2.0
2019-11-04 10:34:47 +0100 core/v2.1.8
2019-10-12 19:02:09 +0200 core/v2.1.7
2019-09-27 12:15:16 +0000 core/v2.1.6
2019-09-26 16:48:16 +0200 python/v0.11.5
2019-09-04 12:17:33 +0200 legacy/v1.8.3
2019-09-04 12:17:33 +0200 core/v2.1.5

# Docker python:3.7.3

2019-08-12 16:29:32 +0200 core/v2.1.4
2019-08-06 11:36:45 +0200 legacy/v1.8.2
2019-08-05 15:59:33 +0200 core/v2.1.3
2019-07-31 18:00:52 +0200 python/v0.11.4
2019-06-28 12:41:23 +0200 core/v2.1.2
2019-06-04 12:24:59 +0200 core/v2.1.1
2019-05-29 18:59:19 +0200 python/v0.11.3

# Docker python, moved to root

2019-04-25 16:56:54 +0200 legacy/v1.8.1

# Docker Dead (Debian 9)

2019-03-05 13:49:42 +0100 core/v2.1.0
2019-02-27 13:25:56 +0100 python/v0.11.2
2019-02-24 17:42:01 +0100 legacy/v1.8.0
2019-02-24 17:42:01 +0100 legacy/bl1.8.0
2019-02-24 17:22:10 +0100 core/bl2.0.3
2018-12-28 13:00:35 +0100 python/v0.11.1
2018-12-19 18:10:41 +0100 legacy/v1.7.3
2018-12-19 18:10:41 +0100 legacy/bl1.6.1
2018-12-17 23:18:02 +0100 legacy/v1.7.2
2018-12-06 16:40:55 +0100 python/v0.11.0
2018-12-05 11:40:57 +0100 core/v2.0.10
2018-12-04 14:20:16 +0100 core/br2.0.1
2018-12-04 14:20:16 +0100 core/bl2.0.2
2018-11-05 13:56:15 +0100 core/v2.0.9
2018-10-28 13:27:54 +0100 core/v2.0.8
2018-10-25 11:57:56 +0200 legacy/v1.7.1
2018-09-04 18:24:41 +0200 legacy/v1.7.0
2018-09-04 18:24:41 +0200 legacy/bl1.6.0
2018-08-27 17:47:14 +0200 legacy/v1.6.3
2018-08-27 17:47:14 +0200 legacy/bl1.5.1
2018-06-22 15:26:14 +0200 legacy/v1.6.2
2018-06-22 15:26:14 +0200 legacy/bl1.5.0
2018-06-22 14:43:22 +0200 core/v2.0.7
2018-06-21 16:50:38 +0200 python/v0.10.2
2018-06-11 18:51:16 +0200 python/v0.10.1
2018-06-08 16:40:15 +0200 python/v0.10.0
2018-03-20 16:25:03 +0100 core/v2.0.6
2018-03-20 15:44:20 +0100 legacy/v1.6.1
2018-03-20 15:44:20 +0100 legacy/bl1.4.0
2018-03-05 19:14:04 +0100 python/v0.9.1
2018-03-01 05:47:33 +0100 core/v2.0.5
2018-02-13 23:11:18 +0100 core/bl2.0.1
2018-02-06 22:12:17 +0100 python/v0.9.0
2018-01-28 16:56:05 +0100 core/br2.0.0
2018-01-28 16:56:05 +0100 core/bl2.0.0
2017-11-16 20:03:26 +0100 legacy/v1.6.0
2017-08-16 14:28:21 +0200 legacy/v1.5.2
2017-08-16 13:52:01 +0200 legacy/bl1.3.3
2017-07-31 22:43:28 +0200 legacy/v1.5.1
2017-07-31 10:06:42 +0200 legacy/bl1.3.2
2017-07-05 12:52:56 +0200 python/v0.7.16
2017-06-19 00:00:50 +0200 python/v0.7.15
2017-06-18 23:41:15 +0200 python/v0.7.14
2017-05-19 17:41:10 +0200 legacy/v1.5.0
2017-04-19 14:20:48 +0200 python/v0.7.13
2017-02-23 11:56:54 +0100 python/v0.7.12
2017-02-22 15:39:07 +0100 python/v0.7.11
2017-02-11 20:16:11 +0100 python/v0.7.10
2017-02-01 14:57:59 +0100 legacy/bl1.3.1
2017-01-25 19:05:33 +0100 python/v0.7.9
2017-01-25 14:04:20 +0100 legacy/v1.4.2
2016-11-27 13:49:20 +0100 python/v0.7.8
2016-11-23 13:52:10 +0100 python/v0.7.7
2016-10-26 18:06:13 +0200 legacy/v1.4.1
2016-10-21 15:25:32 +0200 python/v0.7.6
2016-10-10 11:02:04 +0200 python/v0.7.5
2016-10-06 15:03:11 +0200 legacy/bl1.3.0
2016-09-28 14:38:08 +0200 python/v0.7.4
2016-09-27 22:54:31 +0200 python/v0.7.3
2016-09-27 22:39:31 +0200 python/v0.7.2
2016-09-27 22:24:30 +0200 python/v0.7.1
2016-08-31 14:02:53 +0200 legacy/v1.4.0
2016-06-30 16:47:17 +0200 python/v0.7.0
2016-06-23 18:39:02 +0200 python/v0.6.13
2016-06-07 15:27:05 +0200 legacy/v1.3.6
2016-02-15 16:20:21 +0100 python/v0.6.12
2016-02-15 15:29:19 +0100 legacy/v1.3.5
2016-01-17 00:37:39 +0100 python/v0.6.11
2015-12-24 17:31:28 +0100 python/v0.6.10
2015-12-24 17:17:20 +0100 python/v0.6.9
2015-12-21 20:41:19 +0100 python/v0.6.8
2015-10-19 19:50:59 +0200 python/v0.6.7
2015-08-04 00:45:59 +0200 legacy/v1.3.4
2015-06-03 16:47:01 +0200 python/v0.6.6
2015-06-03 16:47:01 +0200 python/v0.6.5
2015-06-03 14:54:13 +0200 python/v0.6.4
2015-04-02 17:47:28 +0200 legacy/v1.3.3
2015-03-21 10:44:30 +0100 legacy/v1.3.2
2015-02-22 14:40:21 +0100 python/v0.6.3
2015-02-22 14:28:47 +0100 python/v0.6.2
2015-02-16 15:23:30 +0100 legacy/v1.3.1
2015-01-30 23:55:29 +0100 python/v0.6.1
2015-01-30 18:50:50 +0100 python/v0.6.0
2014-12-27 16:05:34 +0100 legacy/v1.3.0
2014-10-19 23:14:06 +0200 python/v0.5.4
2014-08-08 18:24:56 +0200 python/v0.5.3
2014-07-31 19:44:03 +0200 legacy/v1.2.1
2014-07-30 21:05:13 +0200 python/v0.5.2
2014-07-30 20:39:40 +0200 python/v0.5.1
2014-07-03 01:20:34 +0200 legacy/v1.2.0
2014-06-11 20:42:48 +0200 legacy/v1.1.0
2014-04-29 14:38:32 +0200 legacy/v1.0.0
2014-02-03 22:24:54 +0100 python/v0.5.0
'''
