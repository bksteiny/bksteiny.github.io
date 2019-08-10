FROM ruby:2.6.3

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get -y update && apt-get -y install nodejs

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install
COPY . /usr/src/app

EXPOSE 4000
CMD ["bundle", "exec", "jekyll", "serve", "--host=0.0.0.0"]
