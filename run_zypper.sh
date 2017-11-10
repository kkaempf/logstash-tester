#!/bin/bash
echo "Running the zypper dir."
echo "Logstash config is stored at zypper/config, test cases at zypper/test"
./logstash-tester.sh -d zypper $@
