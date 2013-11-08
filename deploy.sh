#!/bin/bash
# Run me by sh deploy.sh

git push origin development &&
heroku maintenance:on --app workcheetah-staging &&
git push staging development:master &&
heroku run rake db:migrate --app workcheetah-staging &&
heroku maintenance:off --app workcheetah-staging &&
heroku restart --app workcheetah-staging

exit