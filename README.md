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

## CREATE TABLE
  Creación de tablas dentro de nuestra base de datos, donde estaran incluidas dentro de un archivo llamado **2-create-tables-sql**:
  ```sql
  # archivo 2-create-tables.sql
  -- Base para crear las tablas
  # creando nuestra tabla de lineas
  CREATE TABLE `lines` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(10) NOT NULL,
    `color` VARCHAR(15) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  
  ) 
  ```
  Nos vemos a la terminal para añadir la tabla:
  ```bash
  # cuando tienes instalado en su sistema mariadb
  mysql < 2-create-tables.sql
  # comando para insertar archivo .sql dentro de un contenedor de docker
  docker exec -i nombre_contenedor sh -c 'exec mysql -uroot -pcontraseña' < "nombre_archivo.sql"
  ```
  Comprobamos la inserción de la tabla:
  ```bash
  # nos movemos al contenedor
  docker-compose exec nombre_contenedor bash
  # ingresamos al servidor de base de datos
  mysql -u root -p
  # dentro de mariadb seleccionamos la BD
  use nombre_db
  # ejecutamos para ver las tablas
  show tables;
  # mas detallado la tabla
  describe `nombre_tabla`;
  ```
## Tren, Estación
  Debemos crear las dos tablas que  nos faltan que son para **trenes** y las **estaciones** por lo cual usaremos un archivo para su inserción dentro del servidor de base datos que estemos usando en mi caso dentro de un contanedor de docker.
  
  Creamos nuestro archivo de nombre **train-station.sql**:
  ```bash
  -- Creación de la tabla de trains
  CREATE TABLE `trains` (
    `serial_number` VARCHAR(10) NOT NULL,
    `line_id` BIGINT(20) UNSIGNED NOT NULL,
    `type` TINYINT(4) NOT NULL,
    `year` INT(4) NOT NULL,

    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (serial_number),
    CONSTRAINT `trains_line_id_foreign` 
    FOREIGN KEY (`line_id`) REFERENCES `lines` (`id`)
  ) 
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

  -- Creación de la tabla de stations
  CREATE TABLE `stations` (
    `id` BIGINT(20),

    `name` VARCHAR(50) NOT NULL,
    -- `icon` VARCHAR(100) NOT NULL,

    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  ) 
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;
  ```
  Comando dentro de la terminal:
  ```bash
  docker exec -i nombre_contenedor sh -c 'exec mysql -uroot -pcontraseña name_database' < "archivo.sql"
  ```
## Modificando tablas con ALTER TABLE
  Para poder modificar al un error que se puedo haber cometido dentro de alguna tabla como un tipo de dato con la sentencia de **AFTER TABLER**, señalando dentro de que base de datos, la tabla el cual se realizaran los cambios.

  Podemos modificar como el tipo de dato despues de la columna, podemos añadir una llave primaria si es necesario.

  Los cambios a realizar es a la tabla de ***stations***.
  ```bash
  # le decimos la base datos que queremos usar
  use my;
  # los cambios a la tabla
  ALTER TABLE `stations`
  MODIFY `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  ADD PRIMARY KEY(id);
  ```

  [ALTER TABLE](https://mariadb.com/kb/en/alter-table/)

  Creación de la tabla ***stations_delete***:
  ```bash
  CREATE TABLE `stations_delete` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    -- `icon` VARCHAR(100) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
  ) 
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;
  ```

## Insertando información en la base de datos
  Para poder insertar de información debemos usar la sentencia de **INSERT INTO** detallando a la tabla que vamos a llenar de datos, especificar las columnas que queremos llenar y al final lista de los valores.

  Tendremos por cada uno de nuestras tablas un archivo especifico como: insert-lines.sql, insert-trains.sql y insert-stations.sql donde cada uno de ellas contendran todo la información que llevara nuestra base de datos.

  [INSERT](https://mariadb.com/kb/en/insert/)

## Actualizando información: UPDATE
  Teniendo los resgistros dentro de nuestra base de datos, dentro de ellos hay algunos error las cuales podemos corregir con la sentencia de **UPDATE** para actulizar informaciones de un registro que este guardado dentro de la DB:
  ```bash
  # sentencia
  UPDATE `name_table`
  SET column_name = `New value`
  WHERE column_condition = "value_condition";
  ```
  Como ejemplo tomaremos nuestra tabla de **stations** donde actualizaremos algunos campos, trabajando con el archivo de ***07-updating-info.sql***.

## Borrando datos: DELETE
  Para poder borrar registro de información dentro de nuestra base de datos necesitamos de la sintaxis de [**DELETE**](https://mariadb.com/kb/en/delete/) el cual puede ser muy peligroso si no se especifica de donde queremos eliminar dicha información.

  Debes poner una condición que filtre unicamente los datos que se quieren eliminar sin olvidarse del **WHERE**, a no de ser que queramos eliminar una tabla completa donde se eliminaran todos los registros quedando completamente vacia.

  Otra sintaxis que nos permite borrar tambien datos es [**TRUNCATE TABLE**](https://mariadb.com/kb/en/truncate-table/) dejara la tabla vacia pero va reiniciar los ***ids***.

  ***DELETE FROM WHERE***
  ```bash
  DELETE FROM `table_name`
  WHERE colum_condition = "value_condition";
  ```
  Para obtener el id de una estación en particular de la BD con el siguiente comando:
  ```bash
  # la cual sera eliminada de la tabla
  SELECT id FROM stations WHERE name = "Merced";
  # las sentencias en nuestro archivo de 8-delete-record-sql
  ```
  Ejemplo de TRUNCATE TABLE con nuestra tabla de ***stations_delete*** dentro de la tabla ingresamos el conjunto de datos que se encontraran dentro del arcivo de **9-insert-fake-stations.sql** el cual contiene l alista de las estaciones de tren, dichos datos insertamos a la tabla mediante la terminal con el comando que antes ya fue visto.

  Dentro de de nuestra base datos verificamos que se ingreso l ainformación correctamente con:
  ```bash
  # lista de las tablas
  show tables;
  # detalles de la tabla
  describe stations_delete;
  # datos dentro de la tabla
  select * from stations_delete;
  # ahora borramos todo la data que se encuentra en la tabla quedando vacia 
  DELETE FROM stations_delete;
  ```
  Ingresamos nuevamente datos a la tabla donde al usar DELETE este no restablece los ids:
  ```bash
  INSERT INTO stations_delete (name) VALUES
  ("Lázaro Cárdens"),
  ("Ferería"),
  ("Pnttlán"),
  ("Tauga"),
  ("MartínCrrera");
  ```
  Al ejecutar el comando de **select * from stations_delete**, podemos notar que toma nuevos ids con la secuencia donde se habia quedado anteriormente al vaciar la tabla auto incrmentandose: 
  ![Imgur](https://i.imgur.com/ssXjfbe.png)

  Reiniciando el id con **TRUNCATE** dentro de la consola:
  ```bash
  # nuevamente vaciamos la tabla
  delete from stations_delete;
  # usamos truncate en la tabla
  TRUNCATE TABLE stations_delete;
  # ingresamos los datos
  INSERT INTO stations_delete (name) VALUES
  ("Lázaro Cárdens"),
  ("Ferería"),
  ("Pnttlán"),
  ("Tauga"),
  ("MartínCrrera"); 
  ```
  Y llamamos a la tabla y veremos que el id se reinicio:
  ![Imgur](https://i.imgur.com/Sg9WePX.png)

  Para eliminar una tabla usamos el comando de **DROP TABLE nombre_table**

## Listando datos: SELECT
  Estructura básica de un **[SELECT](https://mariadb.com/kb/en/select/)**:
  ![Imgur](https://i.imgur.com/vMjCNje.png)

  Usando select en la terminal:
  ```bash
  # para seleccionar todo
  SELECT * FROM name_table;
  # filtar por columnas en este caso usamos la tabla de lines
  SELECT id, name, color FROM name_table;
  # operaciones matematicas
  SELECT (2 + 2);
  # renombrando el título��,��,
  SELECT (2 + 2) AS Resultado;
  # promedio de años con la tabla de trains
  SELECT AVG(year) FROM trains;
  SELECT AVG(year) AS year_avg FROM trains;
  # juntar tablas
  SELECT
  `lines`.`name`,
  `trains`.`serial_number`
  FROM `lines`
  INNER JOIN `trains`
  ON `lines`.`id` = `trains`.`line_id`;
  ```

## ¿Qué son las consultas anidadas?
  Una consulta anidada es una consulta SQL normal pero por dentro existe una subconsulta para obtener un dato, para traernos información de una tabla a otra.
  Ejemplo:
  ![Imgur](https://i.imgur.com/HkMWM0i.png)
  ![Imgur](https://i.imgur.com/tWOaa2R.png)
  En este tipo de consultas tu consulta anidada debe devolver únicamente un solo registro y una única columna.
  - [Row Subqueries](https://mariadb.com/kb/en/subqueries-row-subqueries/)
  - [Scalar Subqueries](https://mariadb.com/kb/en/subqueries-scalar-subqueries/)

## Creando nuestra primera consulta anidada
  Creamos nuestra tabla de **lines_stations** para el desarrollo de la relaci�n que establecimos al inicio. 

  Despues de crear nuestra tabla dentro de la base de datos procedemos a llenarla con el nuevo archivo de ***11-insert-line-stations-nested.sql*** el cual contiene los datos que se relacionan entre las tablas de **lines y stations**.

## ¿Cómo funciona la geolocalización?
  Podemos calcular distancias usando **MSQL** entre dos puntos distintos usando ***Spatial Functions*** las ultimas versiones de MySQL y MariaDB proveen de una serie de funciones que permiten  hacer cálculos de geolocalización, que nos permiten hacer como:

  - Medir distancias
  - Encontrar si un punto está dentro de un área
  - Guardar polígonos

  Para nedir la distancia necesitaremos de un tipo de dato especial llamado [**POINT**](https://mariadb.com/kb/en/point/) de esta forma podremos usar las funciones para calcular la distancia.

  Dentro de MariaDB las encontramos como [Geographic Functions](https://mariadb.com/kb/en/geographic-functions/).

  [Tutorial: cómo calcular distancias geográficas usando MySQL](https://platzi.com/blog/calcula-distancias-con-mysql/)

  ### La formula de Haversine
  Es muy precisa y para calcularla necesita latitud y longitud de los dos puntos a medir. se usa mucho en astronomia.

  ![](https://static.platzi.com/media/user_upload/Haversine-c3b6677b-d6dc-417f-8c00-965a5139f333.jpg)
  Y la otra forma usando el teorema de pitagoras que es aun mucho mas preciso.

## Creando nuestras consultas de geolocalización
  Creamos nuestra tabla llamada **12-create-geo-table.sql** y para poder insertar información la tabla **13-insert-into-geo-table.sql** el cual contendra las cordenadas de cada estación.

  Ahora crearemos nuestra tabla para medir la distancia que se llamara **14-geo-select.sql**, donde se encontraran los comandos que podemos usar desde un archivo o desde la terminal:
  
  ![Imgur](https://i.imgur.com/N00F4LH.png)

## Geolocalización con consultas anidadas
  Calculamos en kilometros con consultas anidadas ejecutando desde la terminal:��,��,
  ```sql
  SELECT
  ST_Distance_Sphere(
    (
      SELECT `locations`.`location`
      FROM `locations`
      INNER JOIN `stations`
      ON `stations`.`id` = `locations`.`station_id`
      WHERE `stations`.`name` = "Balderas"
    ),
    (
      SELECT `locations`.`location`
      FROM `locations`
      INNER JOIN `stations`
      ON `stations`.`id` = `locations`.`station_id`
      WHERE `stations`.`name` = "Pino Suarez"
    )
  ) / 1000 AS distance;
  ```
  ![Imgur](https://i.imgur.com/GAo8qB7.png)

## �Qu� son los Stored Procedures?
  - Los [Stored Procedures](https://mariadb.com/kb/en/stored-procedures/) o "Procedimientos almacenados" son funciones del lado de la base de datos. 
  - Son funciones que quedan guardadas en el gestor de base de datos y se pueden invocar.
  - Sirve para reutilizar c�digo pero m�s importante nos permite crear consultas frecuentes, Son usualmente llamados rutinas.

  ![Imgur](https://i.imgur.com/MGZVBEf.png)

  - **Prepared Statements**:
    En un procedimiento almacenado tambi�n podemos tener consultas preparadas. Esto nos permite tener una cadena de texto con c�digo SQL que podremos ejecutar.
  
  - �Deber�a aplicar esta l�gica desde un lenguaje mejor?: Depende de tu equipo en la organizaci�n y de qui�n quiera tener el control de las consultas.

## Crea tus primeras Stored Procedures
  Crearemos nuestros primeros procedimientos reservados, dentro de nuestro archivo **15-stored-procedures.sql**.
  - [CREATE PROCEDURE](https://mariadb.com/kb/en/create-procedure/)
  - [SELECT INTO](https://mariadb.com/kb/en/selectinto/)
  - Para poder eliminar un procedimiento reservado con el siguiente comando *DROP PROCEDURE name_procedure;**.
  - Para llamar al procedimiento con el comando **CALL name_procedure(values);**. 
  - Como ejemplo usaremos las dos primeras cordenadas, dentro de la imagen tenemos lo que es nuestro **procedimiento reservado**, **las cordenadas** y la **el llamado del procemiento con los valores que solicita**:
   
  - Calculando en Kilometros, si cambios el valor de **false** por la de **true** nos devolvera la medida en metros:

    ![Imgur](https://i.imgur.com/YU1oov9.png)

## Prepared statements
  - Crearemos nuestra **Consulta preparada** dentro de nuestro **Procedimiento Reservada** que se encontrara dentro del archivo ***16-prepared-statements.sql***.
  - Nos vamos a la terminal y llamamos al procedimiento que creamos el cual nos devolvera **que estaciones tiene determinada linea del metro:
    ```bash
    CALL get_line_stations("Linea 9");
    ```
  ![Imgur](https://i.imgur.com/MC8o9z6.png)

## ¿Qué son los triggers?
  Los [triggers](https://mariadb.com/kb/en/triggers/) son eventos que ocurren en nuestra base de datos. Podemos escuchar ciertos eventos y hacer acciones cada vez que sucedan. Son similares a las Stored Procedures, con la diferencia de que estas se ejecutan cada vez que algún evento sucede.

  **NEW y OLD**
  Al ser eventos, podemos acceder a los datos nuevos que estamos insertados e incluso a los datos viejos antes de que los nuevos los sutituyan.

  Un trigger también conocido como disparador, es una especie de script en lenguaje de programación SQL, MySQL o PostgreSQL para base de datos.

  Consiste en una serie de procedimientos que se ejecutan, según instrucciones definidas, cuando se lleven a cabo determinadas operaciones, sobre la información que contiene una base de datos.

  Generalmente, un trigger se acciona cuando se ejecutan acciones para insertar, borrar o modificar los datos de una tabla.

## Crea tus primeros triggers
  Crearemos nuestro trigger para poder actualizar algún registro cuando se realizen cambios en un campo, utilizaremos el archivo llamado **17-triggers.sql**.

  ```sql
  USE my_db;

  CREATE TRIGGER update_updated_at_field
  BEFORE UPDATE
  ON `lines`
  FOR EACH ROW
  SET NEW.updated_at = NOW(); 
  ```

  Enviamos nuestro archivo de SQL a nuestra base de datos con:
  ```bash
  mysql -u root -p < 17-triggers.sql
  ```

  Actulizaremos nuestra tabla **lines** donde tomaremos los datos que corresponden al ***id 1***, donde cambiaremos el ***name*** de la linea. Y al momento de actulizar la fecha cambio al momento de realizar los cambios.

  ![Imgur](https://i.imgur.com/SKFX0FN.png)

  Podríamos evitar el trigger modificando el campo updated_at de la siguiente forma:

  ```sql
  ALTER TABLE `lines`
	CHANGE COLUMN `updated_at` `updated_at` 
  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
  ON UPDATE CURRENT_TIMESTAMP AFTER `created_at`;
  ```

  Para la tabla de **stations**.
  ```sql
  ALTER TABLE stations
    MODIFY updateReg TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
  
  DESCRIBE stations;
  ```

## Triggers compuestos

  [CREATE TRIGGER](https://mariadb.com/kb/en/create-trigger/)

  - Crearemos nuestra tabla de **18-create-drivers-table.sql** donde se encontraran nuestros conductores, le insertamos datos desde el archivo **20-fill-drivers-table.sql**.
  
  - Tomaremos nuestra tabla **19-create-active_drivers.sql** el cúal nos indicara los conductores que esten activos, que cuando algun conductor cambie su estado a **1** debe ser insertado en la tabla y cuando deje de trabajar su estado cambie a **0** eliminando el registro de la tabla.

  - Creamos nuestro trigger el cual se encargara de ver del estado que se encuentra el conductor al momento de empezar con su labor. Se encontrara en nuestro archivo de **21-driver-trigger.sql**, todos nuestro archivos debemos enviarlos a nuestra base de datos.

  ![Imgur](https://i.imgur.com/UpFGCql.png)
