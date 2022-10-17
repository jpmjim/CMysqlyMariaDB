# CMysqlyMariaDB
Curso de MySQL y MariaDB

## ¿Cuál es la diferencia entre MySQL y MariaDB?
  Aunque MariaDB es una bufircación MySQL, estos dos sistemas  de gestión de bases de datos siguen siendo  bastante diferentes :
  - MariaDB tiene licencia GPL mientras que MySQL tiene un enfoque de doble licencia GPL y otra comercial.
  - Cada mango se acumulan  de una manera  diferente.
  - MariaDB soporta muchos motores de almacenamiento diferentes.
  - En muchos escenarios, MariaDB ofrece mejor rendimiento.
  - MariaDB es muy similar a MySQL.
  - [](https://www.ionos.mx/digitalguide/hosting/cuestiones-tecnicas/mariadb-vs-mysql/)

## Diagramas conceptuales vs. diagramas físicos
  En todo proyecto, debemos tener una planeación de qué queremos hacer, en el caso de las bases de datos, los diagramas entidad relación son perfectos para tener esa planificación.

  - **Diagrama conceptual**: Este diagrama expresa una visión amplia de lo queremos representar en nuestra base de datos. Permite describir entidades, tipos de entidades y atributos, y establecer relaciones entre entidades.
  ![Imgur](https://i.imgur.com/KKmZlIK.png)
  
  - **Diagrama físico**: Este diagrama es más detallado. Incluye relaciones, tipos de relaciones, tablas, columnas, e incluso tipo de datos. Además, podemos definir  los tipos de llaves que tendrá la BD.
  ![Imgur](https://i.imgur.com/LwHeQNi.png)
  - Las herramientas que podemos usar para realizar nuestros diagramas [Diagrams](https://www.diagrams.net/), para notaciones y símbolos de diagramas entidad-relación podemos usar [Lucidchart](https://www.lucidchart.com/pages/es/simbolos-de-diagramas-entidad-relacion)

- Diagrama conceptual estableciendo relaciones:
  ![](https://i.imgur.com/CnaIP88.png)

- Relaciones en el diagrama físico enlace para su [descarga](https://static.platzi.com/media/public/uploads/diagrama-fisico_c5b5005f-6eb6-44b1-9edf-f6dda8584916.drawio).
 
## Instalación de MariaDB en linux
  - Página de [MariaDB](https://mariadb.org/). Donde podras encontrar toda la documentación sobre la herramienta.

  ### Instalación mediante el repositorio

  - Instalación para sistema operativo ubuntu 22.04 "jammy", versión de mariadb 10.8 y del mirror GigeNET-Chicago
  - Comandos dentro de nuestra terminal:
  ```bash
  #añadimos el respositorio
  sudo apt-get install apt-transport-https curl
  sudo curl -o /etc/apt/trusted.gpg.d/mariadb_release_signing_key.asc 'https://mariadb.org/mariadb_release_signing_key.asc'
  sudo sh -c "echo 'deb https://mirrors.gigenet.com/mariadb/repo/10.9/ubuntu jammy main' >>/etc/apt/sources.list"
  #actulizamos nuestro sistema
  sudo apt-get update
  #instalamos
  sudo apt-get install mariadb-server
  #verificamos la instalación
  mariadb --version
  ```
