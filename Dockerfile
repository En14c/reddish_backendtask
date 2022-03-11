FROM ruby:2.7.2

ARG USER_ID
ARG GROUP_ID

WORKDIR /reddish

RUN addgroup --gid $GROUP_ID reddishuser
RUN adduser --disabled-password --gecos "" --uid $USER_ID --gid $GROUP_ID reddishuser

RUN gem install bundler
COPY ./Gemfile /reddish/Gemfile
COPY ./Gemfile.lock /reddish/Gemfile.lock
RUN bundle install

COPY . /reddish/

RUN chown -R reddishuser:reddishuser /reddish

USER $USER_ID