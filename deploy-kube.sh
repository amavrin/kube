#!/bin/bash

set -ue

# sudo pip3 install kubernetes openshift

unset ANSIBLE_STRATEGY_PLUGINS
unset ANSIBLE_STRATEGY

ansible -m ping all
ansible-playbook kube-dependancies.yml
ansible-playbook kube-prepare-pip.yml
ansible-playbook kube-master.yml
ansible-playbook kube-workers.yml
ansible-playbook kube-ingress.yml -e ingress_type=contour
ansible-playbook misc.yml
ansible-playbook kube-certmgr.yml

echo "find admin config in 'kube-test-manager:.kube/config'"
