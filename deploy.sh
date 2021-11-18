#!/bin/bash

eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 ./id_rsa # Allow read access to the private key
ssh-add ./id_rsa # Add the private key to SSH

git config --global push.default matching
git remote add deploy ssh://postgres@82.65.54.159:47620/srv/web/travis/time-manager-travis
git push deploy master

# Skip this command if you don't need to execute any additional commands after deploying.
ssh postgres@82.65.54.159 -p 47620 <<EOF
  cd ./srv/web/travis/time-manager-travis
  docker-compose build
  docker-compose up
EOF