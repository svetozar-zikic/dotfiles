#!/bin/bash

set -x

# path
PATH=/home/$USER/.zinit/snippets/PZT::modules--gpg/init.zsh/init.zsh

# modify
# [[ -z "$GPG_AGENT_INFO" && ! -S "${GNUPGHOME:-$HOME/.gnupg}/S.gpg-agent" && ! -S "/run/user/$(id -u)/gnupg/S.gpg-agent" ]]; then'

REGEX='if \[\[ -z "$GPG_AGENT_INFO" && ! -S "${GNUPGHOME:-$HOME\/\.gnupg}\/S\.gpg-agent"'
REPLACE=' \&\& ! -S "\/run\/user\/$(id -u)\/gnupg\/S\.gpg-agent"'

/usr/bin/sed -i "s/\(${REGEX}\)/\1${REPLACE}/" "$PATH"
