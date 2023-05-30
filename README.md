# Multi-Project Reproducible Build Attestation

This project will be used to try to reproduce build of some of the larger and well know opensource projects.  

## Directory Structure

The directory structure is as follows:

* **wiki** &nbsp;-&nbsp; The Wiki documentation for this project.  To update, fork and make a PR
* **pubkeys** &nbsp;-&nbsp; The pubkeys used in the various attestments posted in this project
* **trezor** &nbsp;-&nbsp; Directory for verifying the [trezor-firmware](https://github.com/trezor/trezor-firmware) Github repository
  * **verify.sh** &nbsp;-&nbsp; The main verification script to verify `trezor-firmware` builds
  * **repo** &nbsp;-&nbsp; Scratchpad to checkout the repository into (dynamically created)
  * **attest** &nbsp;-&nbsp; Signed attestment files (and failures)

## Trezor Attestation

To perform Trezor attestation, you will need to install GnuPG, Docker and Git. 
The process to do this varies widely based upon your OS, but it should work on
Windows, Linux and macOS without serious modification.  In a general sense, the process is
fairly straight forward.

1. Install GnuPG, Docker and Git.
2. Perform [GnuPG "gen-key"](https://www.gnupg.org/gph/en/manual/c14.html) and save off the UID (User ID) for reference
2. Clone this repo: `git clone https://github.com/brianddk/attestation.git`
3. CD to the proper directory (ie Trezor): `cd ./attestation/trezor`
4. Use your UID to attest a build: `./verify.sh --gpg-key YOUR_GPG_UID core/v2.6.0`

All done!

## Windows Setup

Most builds use Docker under Linux, which is fine if you have an updated Windows OS.
Windows supports something called WSL which allows you to run a Linux kernel from Windows.
It's officially supported by Microsoft and not too terribly complex.  Beyond WSL, you will 
also need to install Docker and GnuPG.  I'll touch on the most basic concepts of these.

1. [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install) - The default Ubuntu distro works fine.
2. [Install Docker](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-containers#install-docker-desktop) - Just follow the first 6 steps to `hello-world`
2. [Enter WSL Shell](https://learn.microsoft.com/en-us/windows/wsl/basic-commands#run-a-specific-linux-distribution-from-powershell-or-cmd) - `wsl` without arguments is usually enough
3. Install GnuPG and GIT in WSL - `sudo apt update && sudo apt install gnupg git`
4. Continue with step \#2 mentioned above in ***Trezor Attestation***

NOTE: I use [Gpg4win](https://www.gpg4win.org/) which works fine under WSL, you just have to remember to execute `gpg.exe` instead of `gpg`.
To name which program to use, prefix the script with `GPG_BIN=gpg.exe`

## Linux

This should be old-hat for most Linux users, but I'll outline the basics.  I'll assume Ubuntu since that is what I'm most familiar with

1. [Install Docker](https://docs.docker.com/engine/install/ubuntu/) - Setup the `apt` repo, install docker, run `hello-world`
2. Install GnuPG and GIT - `sudo apt update && sudo apt install gpg git`
4. Continue with step \#2 mentioned above in ***Trezor Attestation***

## macOS Setup

Validated from a mac user on a 'MacBook Air' running 'MacOS Ventura v 13.3.1'

1. Install brew if not already installed -   `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. Install docker - `brew install --cask docker`, then start it - `$ open /Applications/Docker.app`
3. Verify Docker with Hello World - From a terminal window run `docker run hello-world` which should run without error
4. All Macs come with a 10 year old version of bash. So we need to update bash from 3.2.57 to 4+ at a minimum - `brew install bash`.  As of 05/30/2023, the latest version of bash is 5.2.15. 
5. Install GnuPG, git, wget & coreutils from Terminal - `brew install git gnupg wget coreutils`x
6. Create symbolic link for 'realpath' pointing to 'grealpath'.  On macOS, the version of `realpath` that comes preinstalled does not support the `--relative-to` option. This option is available in the GNU version of realpath, which is a part of GNU coreutils installed from Step #4. You can first determine where `grealpath` is located by running `which -a grealpath`.  Once path is determined, create a symbolic link in the same path location for 'realpath' pointing to 'grealpath'.  Example: `ln -s /opt/homebrew/bin/grealpath /opt/homebrew/bin/realpath`.
7. Continue with step \#2 mentioned above in ***Trezor Attestation***

## Submitting Attestation

For all the builds that are reproducible, the goal is to get as many people to attest
to the build as possible.  If you are willing to do so, please [fork the repo](https://github.com/brianddk/attestation/fork),
run the build, then [submit a PR](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request).
If you have questions on how to do that, please feel free to [post a discussion](https://github.com/brianddk/attestation/discussions)
and I'll try to help.

## Contributing

Please feel free to fork this repo and make PRs if you can attest a build I have
not yet determined how to.  If find issues, please [open an issue](https://github.com/brianddk/attestation/issues/new/choose),
or if you just have a question [post a discussion topic](https://github.com/brianddk/attestation/discussions).  Please try
to review the [Wiki](https://github.com/brianddk/attestation/wiki)

## Todo List

- [x] Trezor Attestation
- [ ] Coldcard Attestation
- [ ] Bitbox Attestation
- [ ] Bitcoin Core Attestation
