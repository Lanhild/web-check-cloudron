#!/bin/bash
set -eu

echo "=> Ensure directories"
mkdir -p /app/data

# user overrides
source /app/data/env.sh

echo "=> Setting permissions"
chown -R cloudron:cloudron /app/data

echo "==> Starting web-check"
exec gosu cloudron:cloudron node /app/code/web-check/server.js

