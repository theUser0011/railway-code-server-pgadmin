#!/bin/bash

PORT=${PORT:-8080}

echo "=================================="
echo "Starting PostgreSQL..."
echo "=================================="

service postgresql start

echo "=================================="
echo "Starting pgAdmin..."
echo "=================================="

python3 /usr/local/lib/python3*/dist-packages/pgadmin4/pgAdmin4.py &

echo "=================================="
echo "Starting code-server..."
echo "=================================="

exec code-server \
  --bind-addr 0.0.0.0:$PORT \
  --auth none \
  --config /dev/null \
  /home/coder/project