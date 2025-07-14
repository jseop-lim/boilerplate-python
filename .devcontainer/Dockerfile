FROM mcr.microsoft.com/devcontainers/base:bookworm

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
    make \
    tmux \
    vim && \
    rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV PATH="/app/.venv/bin:$PATH"
