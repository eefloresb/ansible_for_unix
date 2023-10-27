[![PyPI version](https://img.shields.io/pypi/v/ansible-core.svg)](https://pypi.org/project/ansible-core)
[![Docs badge](https://img.shields.io/badge/docs-latest-brightgreen.svg)](https://docs.ansible.com/ansible/latest/)
[![Chat badge](https://img.shields.io/badge/chat-IRC-brightgreen.svg)](https://docs.ansible.com/ansible/latest/community/communication.html)
[![Build Status](https://dev.azure.com/ansible/ansible/_apis/build/status/CI?branchName=devel)](https://dev.azure.com/ansible/ansible/_build/latest?definitionId=20&branchName=devel)
[![Ansible Code of Conduct](https://img.shields.io/badge/code%20of%20conduct-Ansible-silver.svg)](https://docs.ansible.com/ansible/latest/community/code_of_conduct.html)
[![Ansible mailing lists](https://img.shields.io/badge/mailing%20lists-Ansible-orange.svg)](https://docs.ansible.com/ansible/latest/community/communication.html#mailing-list-information)
[![Repository License](https://img.shields.io/badge/license-GPL%20v3.0-brightgreen.svg)](COPYING)
[![Ansible CII Best Practices certification](https://bestpractices.coreinfrastructure.org/projects/2372/badge)](https://bestpractices.coreinfrastructure.org/projects/2372)

## Licencia
Distribuido bajo la licencia XYZ. Ver `LICENSE` para más información.

# Configurar tu pc/latop para programar en entornos de desarrollo o devops

## Motivo
Cada vez que me instalo una maquina debo configurar mi entorno de escritorio, esto no es seguido, pero entiendase que configurar todo tu equipo tomo al menos unas cuantas horas ó cuando tienes varias personas en una empresa y quieres instalarle o instalarte todos los programas incluyendo los famosos utilitarios como es mi caso entonces opto por programs_devops que me facilita todo desde la primera instalación.

## Estructura de directorios
```mermaid
graph TD
    root --> install_sw
    root --> Readme.md
    root --> site.yml

    install_sw --> defaults
    install_sw --> handlers
    install_sw --> tasks
    install_sw --> templates
    install_sw --> vars

    defaults --> main_yml1[main.yml]
    handlers --> main_yml2[main.yml]
    tasks --> configure-programs_yml[configure-programs.yml]
    tasks --> configure_repo_yml[configure_repo.yml]
    tasks --> get_temp_url_yml[get_temp_url.yml]
    tasks --> install_programs_yml[install_programs.yml]
    tasks --> main_yml3[main.yml]
    templates --> config-linux_j2[config-linux.j2]
    templates --> docker-ce_j2[docker-ce.j2]
    templates --> hashicorp_j2[hashicorp.j2]
    templates --> init_j2[init.j2]
    templates --> nodejs_j2[nodejs.j2]
    templates --> virtualbox_j2[virtualbox.j2]
    vars --> main_yml4[main.yml]
```

## Paquetes 
<pre>
- <img src="https://3.bp.blogspot.com/-xhNpNJJyQhk/XIe4GY78RQI/AAAAAAAAItc/ouueFUj2Hqo5dntmnKqEaBJR4KQ4Q2K3ACK4BGAYYCw/s1600/logo%2Bgit%2Bicon.png" alt="git icon" width="20"/>         <a href="www.github.com">git</a>
- <img src="https://e7.pngegg.com/pngimages/404/38/png-clipart-ansible-openshift-g2-technology-group-logo-configuration-management-special-event-angle-text.png" alt="git icon" width="30"/>        <a href="ansible.com">ansible</a>
</pre>

# Alcance

- **[Ubuntu 22.04](www.ubuntu.com)** 

## Procedimiento de instalacion
Para poder tener a disponibilidad todos los paquetes se debe instalar el SO ubuntu en tu maquina (ver video) 

a. [Instalar Ubuntu destkop](https://www.youtube.com/watch?v=8MRibUo9VAA)

b. Instalar ansible 

```shell
apt install python3 
apt install python3-pip
pip3 install ansible-core
ansible-galaxy collection install community.general
```

```shell
ansible-playbook -i inventory site.yml -u <tu usuario> --private-keys <tu_llave>
```

c.- Habilitar el usuario
```yaml
    # Modificar el usuario dentro de la estructura de directorios
    usuarios:
     - user: eflores
       home: /home/eflores
       tmp: /tmp
       path: /tmp/examples
    # El usuario lo reemplazas por el nombre declarado en tu cuenta
```

# Autor
@sfi-networks



