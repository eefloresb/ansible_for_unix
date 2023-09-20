# Configurar tu pc/latop para programar para devops

## Motivo
En sfinetworks deseamos facilitar las herramientas necesarias para que cada integrante que se incorpora pueda instalar todos los programas necesarios que se usa en la empresa, fiel a su estilo sfi-networks apuesta por el codigo abierto (opensource) que de la mano con ansible te permite tener tu maquina lista para programar.

## Objetivo
Facilitar al compañero las herramientas de manera rapida y que se pueda acoplar al equipo en el menor tiempo posible

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



