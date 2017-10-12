FROM ruby:2.3.5
MAINTAINER yutaf <yutafuji2008@gmail.com>

RUN \
  apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
#    mysql-client \
    supervisor \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /app

WORKDIR /app
COPY myapp/Gemfile myapp/Gemfile.lock /app/
RUN echo 'gem: --no-rdoc --no-ri' >> $HOME/.gemrc && \
  gem install bundler && \
#  bundle config build.nokogiri --use-system-libraries && \
  bundle install

# Set up script for running container
COPY scripts/run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run.sh

COPY etc/supervisord.conf /etc/supervisor/conf.d/
CMD ["/usr/bin/supervisord"]
