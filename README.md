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


#### Autor: Heldyis Agüero Espinoza

#### Estado del proyecto: Fase investigativa

#### Enlace del video:
