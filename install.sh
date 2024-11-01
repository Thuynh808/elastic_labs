#!/bin/bash

ansible-playbook elastic_kibana_install.yaml -vv

sleep 5

ansible-playbook elastic_kibana_config.yaml -vv

sleep 5

ansible-playbook zeek.yaml -vv

systemctl status elasticsearch.service --no-pager
systemctl status kibana.service --no-pager
ss -ntulp | grep 9200
ss -ntulp | grep 5601
ansible node1,node2 -a "zeekctl status"


