# Crear usuarios genericos

## Usuarios administradores de Canvia 
crea usuarios administradores de los SO UNIX, soportado para los sistemas:

* AIX
* Linux

## Detalles del codigo
Define la lista de usuarios que se va a insertar en el archivo sudoers
```yaml
  - name: "Añadir los usuarios solicitados a sudoers"
    lineinfile:
      path: /etc/sudoers
      regexp: '^{item.user}}.*ALL'
      line: '{{item.user}} ALL=(ALL) NOPASSWD: ALL'
      validate: '/usr/sbin/visudo -cf %s'
      backup: yes
    loop: "{{ usuarios }}"
```
## Lista de usuarios soportados 

- cnvbkp
- cnvmnt 
- cnvdba
- cnvinfra