# bksteiny.github.io

## Update Gemfile.lock
_Documented from https://www.chrisblunt.com/rails-on-docker-quickly-create-or-update-your-gemfile-lock/_

#### Create Gemfile.lock
docker run --rm -v $(pwd):/usr/src/app -w /usr/src/app ruby:2.6.3 bundle lock

#### Update Gemfile.locl
docker run --rm -v $(pwd):/usr/src/app -w /usr/src/app ruby:2.6.3 bundle lock --update