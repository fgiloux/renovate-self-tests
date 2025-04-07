#!/bin/bash

# Check if PS1 is unset; using ${PS1:-} to avoid "unbound variable" error
# in non-interactive shells.
sed -i '7s/\[ -z "$PS1" \]/[ -z "${PS1:-}" ]/' /etc/bash.bashrc

ls -lah /var/run/docker.sock

echo "log level: $LOG_LEVEL"
cat $RENOVATE_CONFIG_FILE
sed "s/{{ process.env.RH_REGISTRY_USERNAME }}/$RH_REGISTRY_USERNAME/g" $RENOVATE_CONFIG_FILE > /tmp/new-renovate.js
REPL=$(sed -e 's/[&\\/]/\\&/g; s/$/\\/' -e '$s/\\$//' <<< $RH_REGISTRY_PASSWORD)
sed -i "s/{{ process.env.RH_REGISTRY_PASSWORD }}/${REPL}/g" /tmp/new-renovate.js
cp /tmp/new-renovate.js $RENOVATE_CONFIG_FILE
docker login -u $RH_REGISTRY_USERNAME -p $RH_REGISTRY_PASSWORD registry.redhat.io
renovate
# runuser -u ubuntu docker login -u "${RH_REGISTRY_USERNAME}" -p "${RH_REGISTRY_PASSWORD}" registry.redhat.io
# runuser -w RH_REGISTRY_USERNAME,RH_REGISTRY_PASSWORD -u ubuntu docker login -u "${RH_REGISTRY_USERNAME}" -p "${RH_REGISTRY_PASSWORD}" registry.redhat.io
# runuser -w RH_REGISTRY_USERNAME,RH_REGISTRY_PASSWORD,RENOVATE_CONFIG_FILE,RENOVATE_TOKEN,LOG_LEVEL -u ubuntu renovate

