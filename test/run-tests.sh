#!/bin/bash
echo "===> /tests/run-tests.sh $1 $2"
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

if [[ $1 == "all" || $1 == "patterns" ]]; then
    echo "###  RUN PATTERN TESTS    #####################"
    jruby /usr/share/logstash/vendor/bundle/jruby/1.9/bin/rspec -f p /test/spec/patterns_spec.rb
fi

if [[ $1 == "all" || $1 == "filters" ]]; then
    echo "###  RUN FILTER Tests  ####################"
    if [[ $2 == "y" ]]; then
        /usr/share/logstash/bin/logstash --config.test_and_exit -f /data/config/filter
    fi

    jruby /usr/share/logstash/vendor/bundle/jruby/1.9/bin/rspec -f p /test/spec/filter_spec.rb
fi

