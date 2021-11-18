#!/usr/bin/env bash

mix deps.get # install project depencies
mix ecto.setup
exec mix phx.server