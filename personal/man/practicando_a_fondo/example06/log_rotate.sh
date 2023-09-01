#!/bin/bash 

HOME=/home/srv_ansible/practicando_a_fondo/roles

mkdir -p $HOME/logrotate_role/{defaults,files,tasks,vars,meta}
touch $HOME/logrotate_role/defaults/main.yml
touch $HOME/logrotate_role/vars/main.yml
touch $HOME/logrotate_role/meta/main.yml

cat > $HOME/logrotate_role/tasks/main.yml << EOF
#### tasks/main.yml
---
- name: install logrotate
  yum: 
    name: logrotate 
    state: latest 

- name: Ensure /etc/logrotate.d 
  file:
    path: /etc/logrotate.d/ 
    state: directory 
    owner: root 
    group: root 
    mode: 0755

- name: Deploy /etc/logrotate.conf
  copy:
    src: logrotate.conf 
    dest: /etc/logrotate.conf 
    owner: root 
    group: root 
    mode: 0644

- name: Deploy /etc/cron.daily/logrotate 
  
