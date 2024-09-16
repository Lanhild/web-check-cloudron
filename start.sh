#!/bin/bash
set -eu

echo "=> Ensure directories"
mkdir -p /app/data

[[ ! -f /app/data/env.sh  ]] && cp /app/pkg/env.sh.template /app/data/env.sh

# user overrides
source /app/data/env.sh

echo "=> Setting permissions"
chown -R cloudron:cloudron /app/data

echo "==> Starting web-check"
exec gosu cloudron:cloudron node /app/code/web-check/server.js

