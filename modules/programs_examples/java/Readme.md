# Configurar equipo remoto

## Alcance

a) SO: _Ubuntu 22.04_

## Objetivo

Se requiere configurar en el servidor remoto y en el local la misma
version de java para poder conseguir la renovacion automatica de los
certificados autogenerados.

## Instalar java y tomcat

```shell
    sudo apt install openjdk-17
    sudo apt install tomcat9
```

## Configurar $JAVA_HOME en el servidor remoto

```shell
    sed -rie "s/JAVA_HOME=.*/JAVA_HOME=\"/usr/lib/jvm/java-17-openjdk-amd64\"/g"
    systemctl daemon-reload
```
