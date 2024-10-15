#!/bin/bash


ansible-galaxy collection install -r requirements.yaml -vv

sshpass -p "password" ansible-playbook setupnodes.yaml -vv

ansible-playbook setupreposerver.yaml -vv

ansible-playbook setuprepoclient.yaml -vv

