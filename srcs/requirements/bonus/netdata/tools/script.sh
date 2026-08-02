#!/bin/bash

set -e

curl -fsSL https://get.netdata.cloud/kickstart.sh -o /tmp/kickstart.sh
chmod +x /tmp/kickstart.sh

/tmp/kickstart.sh --non-interactive

exec /usr/sbin/netdata -D