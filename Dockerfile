FROM fluentd:v1.9-1
MAINTAINER Albert Vergés <albert.verges@wesecur.com>
USER root
RUN apk --no-cache add \
                   build-base \
                   ca-certificates \
                   geoip \
                   geoip-dev \
                   libmaxminddb \
                   automake \
                   autoconf \
                   libtool \
                   libc6-compat \
                   ruby \
                   ruby-irb \
                   ruby-dev \
                   logrotate && \
    echo 'gem: --no-document' >> /etc/gemrc && \
    gem install fluent-plugin-elasticsearch fluent-plugin-multi-format-parser fluent-plugin-aws-elasticsearch-service fluent-plugin-kubernetes_metadata_filter fluent-plugin-geoip && \
    apk del build-base ruby-dev && \
    rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem /var/cache/apk/*

ADD logrotate.d/* /etc/logrotate.d/
RUN chmod 0444 /etc/logrotate.d/*