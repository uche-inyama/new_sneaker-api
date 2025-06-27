# FROM ruby:3.0.0
# RUN apt-get update && apt-get install -y \
#   curl \
#   build-essential \
#   libpq-dev &&\
#   curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
#   curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
#   echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
#   apt-get update && apt-get install -y nodejs yarn
# ADD . /sneaker-api
# WORKDIR /sneaker-api
# RUN bundle install
# ENV RAILS_env production
# ENV RAILS_SERVE_STATIC_FILES true
# EXPOSE 3000
# CMD [bash]

FROM ruby:3.0.0

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  build-essential \
  libpq-dev \
  libjemalloc2 \
  postgresql-client \
  libffi-dev \
  pkg-config \
  python3 \
  ca-certificates \
  gnupg \
  && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
  && curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarnkey.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends nodejs yarn \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

ADD . /sneaker-api
WORKDIR /sneaker-api

RUN bundle install

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]

