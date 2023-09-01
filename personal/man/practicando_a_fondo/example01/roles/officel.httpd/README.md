Ansible Role: install httpd
=========

[![Build Status](https://travis-ci.org/officel/ansible-role-httpd.svg?branch=master)](https://travis-ci.org/officel/ansible-role-httpd)
[![Ansible Role](https://img.shields.io/badge/galaxy-officel.httpd-blue.svg?maxAge=2592000)](https://galaxy.ansible.com/officel/httpd/)

only install apache httpd from default package.
maybe configure work is happiness is better to the different tasks.

Requirements
------------

none.

Role Variables
--------------

see defaults/main.yml

Dependencies
------------

none.

Example Playbook
----------------

    - hosts: all
      become: true
      roles:
         - officel.httpd

License
-------

MIT / BSD


Author Information
------------------

This role was created by raki.
