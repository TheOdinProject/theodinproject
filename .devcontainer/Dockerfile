FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-22.04

# Adding the PostgreSQL repository so we can install postgresql-client v15
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg >/dev/null
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
