#!/bin/bash


ansible-galaxy collection install -r requirements.yaml -vv

ansible-playbook setupnodes.yaml -vv

ansible-playbook setupreposerver.yaml -vv

ansible-playbook setuprepoclient.yaml -vv


