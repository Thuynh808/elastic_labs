#!/bin/bash

ansible node1 -m shell -a "echo 'Y' | ./add-agent.sh --stdin"

