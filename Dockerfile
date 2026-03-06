FROM codercom/code-server:latest

USER root

# Install dependencies
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

# Install pgAdmin
RUN pip3 install --break-system-packages pgadmin4 gunicorn

# Project workspace
WORKDIR /home/coder/project

# Install python requirements if exists
COPY requirements.txt .
RUN pip3 install --break-system-packages -r requirements.txt || true

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Remove default code-server config
RUN rm -rf /root/.config/code-server

# Ports
EXPOSE 8080
EXPOSE 5050
EXPOSE 5432

ENTRYPOINT ["/start.sh"]