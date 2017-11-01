FROM ruby:2.4.1

RUN apt-get update -qq && apt-get install -y -qq build-essential
RUN apt-get install -y apt-transport-https

# for postgres
RUN apt-get install -y -qq libpq-dev

# for image processing
RUN apt-get install -y advancecomp gifsicle jhead jpegoptim libjpeg-progs optipng pngcrush pngquant

# for JavaScript runtime
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y nodejs

# for JavaScript dependencies
RUN echo "yarn" && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "." && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN echo "get" && apt-get update && apt-get install -y yarn

# for UTF-8 terminal
RUN apt-get install -y -qq locales
RUN locale-gen C.UTF-8 && /usr/sbin/update-locale LANG=C.UTF-8
RUN apt-get remove -y locales

# editor for terminal
RUN apt-get install -y -qq nano

ENV EDITOR nano
ENV LANG C.UTF-8

# Install Heroku CLI
RUN wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

# Yarn cache
ENV YARN_CACHE_FOLDER /yarn_modules/cache

# Paths
ENV APP_HOME /engine
ENV GEM_HOME /gems
RUN mkdir $APP_HOME
RUN mkdir $GEM_HOME
WORKDIR $APP_HOME

# Cache gems locally
ENV BUNDLE_PATH $GEM_HOME
ENV GEM_PATH $GEM_HOME
ENV GEM_CACHE $GEM_HOME/cache
ENV PATH $PATH:$GEM_HOME/bin
RUN gem install bundler --no-ri --no-rdoc
