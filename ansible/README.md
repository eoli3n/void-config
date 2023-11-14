### Configure

1. Install ansible temp with xbps
2. Install xbps ansible module
```
ansible-galaxy collection install community.general
```
3. Then run
```
ansible-playbook install.yml -K
```
4. Remove Ansible xbps package
