#!/bin/bash

set -e

sleep 10  # TODO: wait on something instead of just sleeping...

echo `df`

createdb -w -U postgres -h postgres galaxy
GALAXY_RUN_ALL=1 bash "$GALAXY_ROOT/run.sh" --daemon --wait
cd "$BIOBLEND_ROOT"
. "$BIOBLEND_VIRTUAL_ENV/bin/activate" && python setup.py install
echo "$BIOBLEND_GALAXY_URL" "$GALAXY_CONFIG_OVERRIDE_MASTER_API_KEY" "$GALAXY_USER" "$GALAXY_USER_EMAIL" "$GALAXY_USER_PASSWD"
cat "$GALAXY_ROOT/main.log"
export BIOBLEND_GALAXY_API_KEY=`. $BIOBLEND_VIRTUAL_ENV/bin/activate && python docs/examples/create_user_get_api_key.py "$BIOBLEND_GALAXY_URL" "$GALAXY_CONFIG_OVERRIDE_MASTER_API_KEY" "$GALAXY_USER" "$GALAXY_USER_EMAIL" "$GALAXY_USER_PASSWD"`
if [ -z "$BIOBLEND_GALAXY_API_KEY" ];
then
    echo "Failed to create test API key."
    exit 1
fi
echo "BIOBLEND KEY IS $BIOBLEND_GALAXY_API_KEY"
echo "GALAXY_CONFIG_OVERRIDE_ADMIN_USERS is $GALAXY_CONFIG_OVERRIDE_ADMIN_USERS"
. $BIOBLEND_VIRTUAL_ENV/bin/activate && tox -e py27
