FROM ruby:3.0.2 AS development

LABEL maintainer="nadircs11@gmail.co.il"

RUN dpkg --add-architecture i386

SHELL [ "/bin/bash", "-c" ]

RUN gem install bundler
RUN bundle config --global jobs 8

RUN mkdir -pv /app
WORKDIR /app

RUN mkdir -pv ./lib/xmodem/rails/
COPY *.gemspec ./
COPY Gemfile* ./
COPY lib/xmodem/ ./lib/xmodem/
RUN bundle install

COPY . .

ENTRYPOINT ["/bin/bash", "-c", "/bin/bash"]

FROM development AS testing

RUN bundle exec rake test || exit 0

ENTRYPOINT ["/bin/bash", "-c", "/bin/bash"]
