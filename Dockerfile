FROM ruby:3.1.2 AS link-rides
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn vim postgresql-client imagemagick
WORKDIR /home/dhuey/rides
COPY ./Gemfile /home/dhuey/rides
COPY ./Gemfile.lock /home/dhuey/rides/
COPY . /home/dhuey/rides
RUN gem install bundler
RUN bundle install --without development test
RUN yarn install

RUN bundle exec DATABASE_URL=postgresql:does_not_exist
RUN yarn run build
RUN yarn run build:css
RUN rails assets:precompile

EXPOSE 3000

CMD ["rails", "server", "-e", "production", "-b", "0.0.0.0"]
