#!/bin/bash

ansible node1 -m shell -a "echo 'Y' | ./agent-install.sh --stdin"

