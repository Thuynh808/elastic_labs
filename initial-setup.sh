#!/bin/bash


ansible-playbook setupnodes.yaml -vv

ansible-playbook setupreposerver.yaml -vv

ansible-playbook setuprepoclient.yaml -vv


