FROM ruby:2.5.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs \
  && apt-get clean && rm -rf /var/lib/apt/lists/*
ENV APP_HOME /top
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* ./
RUN bundle install
COPY . .
