# TA1 - Bases De Datos II - API

Proyecto práctico orientado al desarrollo de una arquitectura descentralizada para la comunicación entre una aplicación web backend y un motor de base de datos relacional hospedado en un entorno Linux.

## Objetivo

Implementar una API RESTful utilizando Node.js que gestione la persistencia de datos sobre la base de datos de prueba **AdventureWorks2025**, que es la base de datos seleccionada por el autor para llevar a cabo el presente proyecto en **SQL Server 2025**, ejecutándose sobre un sistema operativo **Linux Ubuntu versión 24.04**. La comunicación y manipulación de datos se realiza estrictamente a través de **Stored Procedures**.

## Funcionalidades de la API

La API presenta endpoints para realizar operaciones utilizando exclusivamente procedimientos almacenados:

1. **Create:** Ejecución de un SP para registrar nuevos datos.
2. **Read (Consultas):**
   * **Consulta simple:** SP que retorna los registros de una tabla específica.
   * **Consulta con Join:** SP optimizado que combina información de múltiples tablas relacionadas.
3. **Update :** SP para modificar registros existentes.
4. **Delete (Eliminación):** SP para la remoción de registros.

## Requerimientos

* Sistema operativo: **Linux Ubuntu 24.04 LTS**
* Motor de base de datos: **Microsoft SQL Server 2025**
* Base de datos: **AdventureWorks2025**
* Node.js
* npm
* Git
* VSCode (Para desarrollo)

## Instalación de requerimientos

### 1. Actualización del sistema
Se actualizaron los repositorios de paquetes de Ubuntu antes de iniciar la instalación de los programas necesarios.

**sudo apt update**

### 2. Instalación de SQL Server 2025
Se agregó el repositorio oficial de Microsoft que corresponde a SQL Server 2025 para Ubuntu 24.04 y posteriormente se instaló el motor de base de datos. 

**sudo apt install -y mssql-server**

Una vez instalado, se ejecutó la herramienta de configuración:

**sudo /opt/mssql/bin/mssql-conf setup**

Durante la configuración se selección la edición Enterprise Developer y se establecieron las credenciales necesarias para la administración del servidor.

### 3. Verificación del servidor SQL Server
Se comprobó que el servicio de SQL Server se encontrara activo mediante:

**systemctl status mssql-server --no-pager**

El servicio fue identificado como activo y en ejecución

### 4. Instalación de las herramientas de línea de comandos
Se instalaron mssql-tools18 y unixodbc-dev, herramientas utilizadas para interactuar con SQL Server desde la terminal.

**sudo apt install -y mssql-tools18 unixodbc-dev**

Posteriormente, se agregó sqlcmd al PATH del usuario:

**echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
source ~/.bashrc**

Se verificó la instalación mediante:

**sqlcmd -?**

### 5. Verificación de la conexión
Finalmente, se comprobó la conexión al servidor SQL mediante sqlcmd:

**sqlcmd -S localhost -U sa -C**

La conexión fue exitosa y se verificó el funcionamiento del servidor mediante consultas SQL.

### 6. Instalación de AdventureWorks2025
Para este proyecto se tomó la decisión de utilizar la base de datos AdventureWorks2025, que es compatible con SQL Server 2025. Se utilizó el archivo de respaldo proporcionado por Microsoft en su repositorio oficial de ejemplos de SQL Server.

#### 6.1 Creación del directorio para trabajar
Se creó un directorio para almacenar temporalmente el archivo de respaldo:

**mkdir -p ~/Downloads/AdventureWorks**
**cd ~/Downloads/AdventureWorks**

#### 6.2 Descarga la base de datos
Se descargó el respaldo AdventureWorks2025.bak desde las versiones oficiales de los ejemplos de SQL Server:

**wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2025.bak**

Se verificó que el archivo se descargara correctamente:

**ls -lh ~/Downloads/AdventureWorks/AdventureWorks2025.bak**

#### 6.3 Copia de respaldo del directorio de SQL Server
Se creó el directorio utilizado por SQL Server para almacenar respaldos:

**sudo mkdir -p /var/opt/mssql/backup**

Posteriormente, se copió el archivo de respaldo:

**sudo cp ~/Downloads/AdventureWorks/AdventureWorks2025.bak /var/opt/mssql/backup/**

Se verificó que el archivo estuviera disponible:

**sudo ls -lh /var/opt/mssql/backup/**

#### 6.4 Identificación de archivos
Antes de restaurar la base de datos, se consultó la información de los archivos contenidos en el respaldo mediante RESTORE FILELISTONLY:

**RESTORE FILELISTONLY
FROM DISK = '/var/opt/mssql/backup/AdventureWorks2025.bak';
GO**

El respaldo contenía los siguientes archivos lógicos:

AdventureWorks → archivo de datos.
AdventureWorks_log → archivo de registro.

Estos nombres se utilizaron posteriormente en la instrucción RESTORE DATABASE.

#### 6.5 Restauración de la base de datos
La base de datos fue restaurada utilizando el respaldo descargado y asignando los archivos de datos y registro a los directorios correspondientes de SQL Server en Linux:

**RESTORE DATABASE AdventureWorks2025
FROM DISK = '/var/opt/mssql/backup/AdventureWorks2025.bak'
WITH
    MOVE 'AdventureWorks'
        TO '/var/opt/mssql/data/AdventureWorks2025.mdf',
    MOVE 'AdventureWorks_log'
        TO '/var/opt/mssql/data/AdventureWorks2025_log.ldf';
GO**

La restauración finalizó correctamente.

#### 6.6 Verificación de la base de datos
Se verificó que AdventureWorks2025 estuviera registrada correctamente en el servidor:

**SELECT name
FROM sys.databases;
GO**

El resultado confirmó la existencia de AdventureWorks2025

Posteriormente, se consultaron las tablas y vistas disponibles:

**USE AdventureWorks2025;
GO**

**SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
ORDER BY TABLE_SCHEMA, TABLE_NAME;
GO**

La consulta retornó las tablas y vistas pertenecientes a los esquemas dbo, HumanResources, Person, Production, Purchasing y Sales.

Finalmente, se realizó una consulta de prueba sobre la tabla Production.Product:

**SELECT TOP 10 *
FROM Production.Product;
GO**

La consulta retornó correctamente registros de productos.

#### Autor: Heldyis Agüero Espinoza

#### Estado del proyecto: Fase investigativa

#### Enlace del video:
