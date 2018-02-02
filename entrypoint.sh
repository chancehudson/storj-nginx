#! /bin/sh

# Secrets are configured at the swarm level and are provided via files at /run/secrets
# See the docker secrets documentation for more information
# https://docs.docker.com/engine/swarm/secrets/
SECRETS=/run/secrets/

# Load libstorj env config options if they are present
[ -f $SECRETS/STORJ_KEYPASS ] && export STORJ_KEYPASS=$(cat $SECRETS/STORJ_KEYPASS)
[ -f $SECRETS/STORJ_BRIDGE ] && export STORJ_BRIDGE=$(cat $SECRETS/STORJ_BRIDGE) # This defaults to https://api.storj.io
[ -f $SECRETS/STORJ_BRIDGE_USER ] && export STORJ_BRIDGE_USER=$(cat $SECRETS/STORJ_BRIDGE_USER)
[ -f $SECRETS/STORJ_BRIDGE_PASS ] && export STORJ_BRIDGE_PASS=$(cat $SECRETS/STORJ_BRIDGE_PASS)
[ -f $SECRETS/STORJ_ENCRYPTION_KEY ] && export STORJ_ENCRYPTION_KEY=$(cat $SECRETS/STORJ_ENCRYPTION_KEY)

rm /etc/nginx/nginx.conf
storj download-file $CONFIG_BUCKET_ID $CONFIG_FILE_ID /etc/nginx/nginx.conf

exec nginx -g "daemon off;"
