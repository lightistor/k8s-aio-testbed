export _ANSIBLE_CTL_USR="nsiblectl"
export _REMOTE_HOST_USR="nsiblermt"
export _REMOTE_HOST_USRPASS="myuserpass"
ansible-playbook -i /etc/ansible/hosts /home/admin/k8s-aio-testbed/playbooks/k8s-cls-kind/main/k8s-cls-kind-0-install_clustervm_dependencies.yaml -e "user=$_REMOTE_HOST_USR" -e "vkubectl=v1.23.0" -e "vkindcli=v0.12.0" -e "kind_img_tag=v1.23.4" -e "vhelmcli=v3.4.1" --user=$_ANSIBLE_CTL_USR -e "ansible_become_pass=oracle12"

ansible-playbook -i /etc/ansible/hosts /home/admin/k8s-aio-testbed/playbooks/k8s-cls-kind/main/k8s-cls-kind-1-create_baseline_iac_descriptor_definitions.yaml -e "user=$_REMOTE_HOST_USR" -e "vmetallb=v0.12.1" --user=$_ANSIBLE_CTL_USR -e "ansible_become_pass=oracle12"

ansible-playbook -i /etc/ansible/hosts /home/admin/k8s-aio-testbed/playbooks/k8s-cls-kind/main/k8s-cls-kind-1-create_baseline_iac_descriptor_definitions.yaml -e "user=$_REMOTE_HOST_USR" -e "vmetallb=v0.12.1" --user=$_ANSIBLE_CTL_USR -e "ansible_become_pass=oracle12"