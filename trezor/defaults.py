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
    msg="""#!/bin/bash
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
"""
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
