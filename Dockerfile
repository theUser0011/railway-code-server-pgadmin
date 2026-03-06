FROM codercom/code-server:latest

USER root

# Install Python + Postgres + pgAdmin
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    git \
    curl \
    postgresql \
    postgresql-contrib \
    pgadmin4

WORKDIR /home/coder/project

COPY requirements.txt .
RUN pip3 install --break-system-packages -r requirements.txt || true

COPY start.sh /start.sh
RUN chmod +x /start.sh

RUN rm -rf /root/.config/code-server

EXPOSE 8080
EXPOSE 5432
EXPOSE 5050

ENTRYPOINT ["/start.sh"]