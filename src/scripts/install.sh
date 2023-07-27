#!/bin/bash
set -e

# This example uses envsubst to support variable substitution in the string parameter type.
# https://circleci.com/docs/orbs-best-practices/#accepting-parameters-as-strings-or-environment-variables
TO=$(circleci env subst "${PARAM_TO}")
VERSION=$(circleci env subst "${PARAM_VERSION}")
CONFIG_FILE=$(circleci env subst "${PARAM_CONFIG_FILE}")
PROJECT_TOKEN=$(circleci env subst "${PARAM_PROJECT_TOKEN}")
# If for any reason the TO variable is not set, default to "World"
echo "Hello ${TO:-World}!"


sudo apt-get update && sudo apt-get install -y rsync

curl "https://update.brisktest.com/brisk/$VERSION/linux-amd64/brisk" -o brisk
chmod +x brisk
sudo mv brisk /usr/local/bin/brisk
export BRISK_CI=true
export BRISK_PROJECT_CONFIG_FILE=$CONFIG_FILE
export BRISK_PROJECT_TOKEN=$PROJECT_TOKEN
export NO_TERM=true
brisk version


