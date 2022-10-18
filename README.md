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
  ### Instalación o uso de Docker
  - Previamente tener docker instalado en su sistema.
  - Dentro de nuestra carpeta crear el archivo **docker-compose.yml** donde se encontrara toda la configuración.
  ```yml
  version: '3.3'
  services:
    mariadb:
      image: mariadb:latest
    environment:
      - MARIADB_DATABASE=my_db
      - MARIADB_USER=root
      - MARIADB_PASSWORD=123456
      - MARIADB_ROOT_USER
      - MARIADB_ROOT_PASSWORD=123456
    volumes:
      - ./mariadb_data:/var/lib/mariadb/data
    ports:
      - '3808:3808'
  ```
  - Ejecutar dentro de la terminal el siguiente comando, el cual se encargade la creación del contenedor donde se alojara nuestro base de datos en este caso **MariaDB**.
  ```bash
  docker-compose up mariadb
  ```
  - Y listo tenemos mariadb sin la necesidad de instalarlo directamente dentro de nuestra computadora.
  - Tener tambien un archivo **.gitignore** para ignorar toda la data que se esta almacenando dentro de la carpeta ***mariadb_data*** si estan trabajando dentro de un respositorio.

## Archivos SQL: CREATE DATABASE
  - Crearemos nuestra base de datos que estaremos usando, con las sentencias o con las siguientes palabras:
  ```bash
  CREATE DATABASE database_name
  # ingresamos a nuestra BD
  use database_name
  # creación de tablas
  CREATE TABLE table_name
  ```
  - Ejecutamos el comando de crear nuestra base de datos dentro de mi servidor de base de dattos:
  ```bash
  # iniciamos sesión -- instalación en el sistema
  sudo mysql -u root -p
  # ingresamos todos los datos que requiere para el acceso
  # -------------------------------------------------------
  # conexión con docker
  # verificamos que nuestro contenedor esta corriendo
  docker-compose ps
  # ingresamos a la consola nuestro del contenedor
  docker-compose exec mariadb bash
  # ejecutamos el comando para ingresar a la base de datos
  mysql -u root -p
  # nos pedira los datos que fueron configurados dentro del archivo de docker-compose.yml
  ```

  - Dentro del servidor de la base de datos si estas usando Docker debes ingresar los mismos datos que fueron configurados previamente en los archivos.
  - En mi caso mi base de datos tiene el nombre de **my_db**.
  ```bash
  # creación DB
  MariaDB [(none)]> CREATE DATABASE my_db;
  # ver todas las DB
  SHOW DATABASES;
  # eliminar una DB
  DROP DATABASE database_name;
  ```
  - Otra manera de crear un DB es cargando archivos con la extension de **sql** nos vamos a la terminal ingresamos el comando:
  ```bash
  mysql < nombre_archivo.sql
  ```

## Manejo de usuarios para la base de datos
  No es bueno de estar usando al usuario root, es mejor tener propios usuarios y darle los permisos necesarios para el desarrollo de su base de datos. Veremos como crear nuestro usuario usando el comando de [**GRANT**](https://mariadb.com/kb/en/grant/#grant-option) para la asignación de permisos al usuario.

  - Ingresamos con el usuario **root** ya dentro del servidor de DB:
  ```bash
  # crear
  CREATE USER 'name_user'@'localhost' IDENTIFIED BY '******';
  # eliminar
  DROP USER 'nombre_usuario'@'localhost';
  # mostrar los usuarios
  SELECT user FROM mysql.user;
  # dar todos los privilegios
  GRANT ALL PRIVILEGES ON *.* TO 'name_user'@'localhost';
  FLUSH PRIVILEGES;
  ```

  - Ahora ingresamos con el usuario creado en este caso **jpmjim**
  ```bash
  mysql -u jpmjim -p 
  ```

## Conexion DBeaver con MariaDB
  - Página de [DBeaver](https://dbeaver.io/download/) donde encontraras toda la documentación y como poderlo instalar en los diferentes sistemas operativos, en este caso para ubuntu:
  ```bash
  # en la terminal
  sudo snap install dbeaver-ce
  ```
  - Conexión con los datos ya establecidos dentro del servidor de la base de datos.
    ![Imgur](https://i.imgur.com/crFSxja.png)
    ![Imgur](https://i.imgur.com/NvozSSH.png)
