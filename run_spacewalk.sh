#!/bin/bash
echo "Running the spacewalk dir."
echo "Logstash config is stored at spacewalk/config, test cases at spacewalk/test"
./logstash-tester.sh -d spacewalk $@
