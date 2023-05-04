#!/bin/sh
set -euo pipefail
set -v

# Clean package cache
pkg clean -ay

# Remove temporary ssh host keys
rm -v /etc/ssh/*key*

# Disable root login
sed -i '' -e '$ d' /etc/ssh/sshd_config

# Unset root password
chpass -p !
