# Assumes you have Heroku CLI and are logged in
# Args are in order as listed below
HEROKU_APP_NAME=$1
SECRET=$2

ECHO "Creating $HEROKU_APP_NAME"

heroku apps:create $HEROKU_APP_NAME

ECHO "Creating infrastructure for $HEROKU_APP_NAME"

heroku addons:create sendgrid:starter -a $HEROKU_APP_NAME
heroku addons:create cleardb:ignite -a $HEROKU_APP_NAME
heroku addons:create heroku-redis:hobby-dev -a $HEROKU_APP_NAME

ECHO "Finished creating infrastructure for $HEROKU_APP_NAME"

ECHO "Setting Heroku env vars for $HEROKU_APP_NAME"

heroku config:set WP_ENV=development WP_HOME=https://$HEROKU_APP_NAME.herokuapp.com WP_SITEURL=https://$HEROKU_APP_NAME.herokuapp.com/wp AUTH_KEY=$SECRET SECURE_AUTH_KEY=$SECRET LOGGED_IN_KEY=$SECRET NONCE_KEY=$SECRET AUTH_SALT=$SECRET SECURE_AUTH_SALT=$SECRET LOGGED_IN_SALT=$SECRET NONE_SALT=$SECRET -a $HEROKU_APP_NAME

ECHO "Finished Setting Heroku env vars for $HEROKU_APP_NAME"