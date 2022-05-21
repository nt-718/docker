FROM ruby:3.1.2

ENV BUNDLER_VERSION=2.3.10

RUN mkdir /docker
WORKDIR /docker
COPY /Gemfile /docker/Gemfile
COPY /Gemfile.lock /docker/Gemfile.lock
RUN gem install bundler -v ${BUNDLER_VERSION} \
    && bundle config --local set path 'vendor/bundle' \ 
    && bundle install
COPY . /docker

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]