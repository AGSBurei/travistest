FROM elixir:latest

WORKDIR /app/back
COPY ./ /app/back/

RUN apt update && \
    apt install -y postgresql-client && \
    apt install -y inotify-tools && \
    mix local.hex --force && \
    mix archive.install hex phx_new 1.6.2 --force && \
    mix local.rebar --force
 
 EXPOSE 4000