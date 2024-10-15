#!/bin/bash

ansible-playbook setupproject.yaml -vv

su - ansible

cd elastic_labs

ansible-galaxy collection install -r requirements.yaml

ansible-playbook setupnodes.yaml -vv

ansible-playbook setupreposerver.yaml -vv

ansible-playbook setuprepoclient.yaml -vv


