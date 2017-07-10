FROM logstash:latest

USER root
RUN zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
  java-devel = 1.8.0

RUN /usr/share/logstash/bin/logstash-plugin install --development

# this gem building doesn't work in ~root
WORKDIR /tmp
RUN jgem build /usr/share/logstash/logstash-core/logstash-core.gemspec
RUN jgem build /usr/share/logstash/logstash-core-plugin-api/logstash-core-plugin-api.gemspec
RUN ls -la
RUN GEM_HOME=/usr/share/logstash/vendor/bundle/jruby/1.9 jgem install ./logstash-core-5.4.3-java.gem
RUN GEM_HOME=/usr/share/logstash/vendor/bundle/jruby/1.9 jgem install ./logstash-core-plugin-api-2.1.12-java.gem

ARG LST
ARG FILTER_CONFIG
ARG PATTERN_CONFIG
ARG FILTER_TESTS
ARG PATTERN_TESTS

ADD $PATTERN_CONFIG /etc/logstash/patterns
ADD $LST/test /test
ADD $FILTER_CONFIG /test/spec/filter_config
ADD $FILTER_TESTS /test/spec/filter_data
ADD $PATTERN_TESTS /test/spec/pattern_data

# drop /data symlink
RUN rm -f /usr/share/logstash/data
ENTRYPOINT ["/test/run-tests.sh"]
#ENTRYPOINT ["/bin/bash"]
