FROM codercom/code-server:latest

USER root

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-full \
    libpq-dev \
    git \
    curl \
    postgresql \
    postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*

# Install pgadmin via pip using the bypass flag for PEP 668
RUN pip3 install --break-system-packages pgadmin4

WORKDIR /home/coder/project

# Copy and install Python requirements
COPY requirements.txt .
RUN pip3 install --break-system-packages -r requirements.txt || true

# Setup start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Clean up default config to prevent collisions
RUN rm -rf /root/.config/code-server

# Standard ports for Code-Server, pgAdmin, and Postgres
EXPOSE 8080
EXPOSE 5050
EXPOSE 5432

ENTRYPOINT ["/start.sh"]