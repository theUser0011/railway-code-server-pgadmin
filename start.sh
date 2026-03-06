#!/bin/bash

PORT=${PORT:-8080}

echo "=================================="
echo "Starting PostgreSQL..."
echo "=================================="

service postgresql start

echo "=================================="
echo "Setting pgAdmin credentials..."
echo "=================================="

export PGADMIN_DEFAULT_EMAIL=admin@example.com
export PGADMIN_DEFAULT_PASSWORD=admin123

echo "=================================="
echo "Starting pgAdmin..."
echo "=================================="

gunicorn --bind 0.0.0.0:5050 pgadmin4.pgAdmin4:app &

echo "=================================="
echo "Starting code-server..."
echo "=================================="

exec code-server \
  --bind-addr 0.0.0.0:$PORT \
  --auth none \
  --config /dev/null \
  /home/coder/project