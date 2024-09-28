# Proyecto USPG POS

Este proyecto configura una base de datos SQL Server utilizando Docker y un contenedor para el almacenamiento. Se incluye un archivo `docker-compose.yml` para ejecutar el contenedor con las configuraciones necesarias y un archivo `init.sql` para la creación de la base de datos y sus tablas. La base de datos se utilizará como el backend para un **proyecto de sistema de punto de venta** (POS) desarrollado en **ASP.NET MVC con C#**.

## Requisitos Previos

Antes de ejecutar este proyecto, asegúrate de tener instalados los siguientes componentes en tu entorno:

-   [Docker](https://www.docker.com/get-started)
-   [Docker Compose](https://docs.docker.com/compose/install/)
-   [Visual Studio](https://visualstudio.microsoft.com/) (para el desarrollo del proyecto ASP.NET MVC con C#)

## Estructura del Proyecto

El repositorio incluye los siguientes archivos:

-   `docker-compose.yml`: Archivo de configuración para Docker Compose, que define el servicio de base de datos SQL Server.
-   `init.sql`: Script SQL que crea la base de datos `uspg_pos`, junto con las tablas y datos iniciales.

## Instrucciones de Uso

1. **Clonar el repositorio**:

    ```bash
    git clone <URL-del-repositorio>
    cd <nombre-del-repositorio>
    ```

2. **Estructura de carpetas**:

    Asegúrate de que la carpeta contenga ambos archivos `docker-compose.yml` e `init.sql`.

3. **Levantar el contenedor**:

    Ejecuta el siguiente comando para levantar el contenedor de la base de datos:

    ```bash
    docker-compose up -d
    ```

    Este comando creará y ejecutará el contenedor con el nombre `mssql-db`, escuchando en el puerto `1400` de tu máquina local.

4. **Verificar el contenedor**:

    Puedes verificar que el contenedor esté corriendo usando el siguiente comando:

    ```bash
    docker ps
    ```

    Deberías ver un contenedor llamado `mssql-db` en ejecución.

5. **Inicializar la base de datos**:

    Con el contenedor en ejecución, conecta a la base de datos y ejecuta el script `init.sql`. Puedes hacer esto de varias maneras:

    - **Usando `sqlcmd`** dentro del contenedor:

        ```bash
        docker exec -it mssql-db /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'S2V@Cs2JOWgQ' -i /init.sql
        ```

    - O copiar el archivo `init.sql` al contenedor y luego ejecutarlo:

        ```bash
        docker cp init.sql mssql-db:/init.sql
        docker exec -it mssql-db /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'S2V@Cs2JOWgQ' -i /init.sql
        ```

6. **Conectar a la base de datos desde un cliente externo**:

    Puedes conectarte a la base de datos con cualquier cliente SQL, como SQL Server Management Studio (SSMS) o Azure Data Studio, usando las siguientes credenciales:

    - **Servidor**: `localhost,1400`
    - **Usuario**: `sa`
    - **Contraseña**: `S2V@Cs2JOWgQ`

7. **Integrar con el Proyecto ASP.NET MVC**:

    La base de datos `uspg_pos` está diseñada para ser el backend del sistema de punto de venta (POS) desarrollado en **ASP.NET MVC con C#**. Asegúrate de actualizar la cadena de conexión en el archivo `appsettings.json` del proyecto ASP.NET de la siguiente manera:

    ```json
    "ConnectionStrings": {
      "DefaultConnection": "Server=localhost,1400;Database=uspg_pos;User Id=sa;Password=S2V@Cs2JOWgQ;TrustServerCertificate=True;"
    }
    ```

    De este modo, la aplicación ASP.NET podrá conectarse a la base de datos y operar con las tablas creadas.

## Apagar el Contenedor

Para detener y eliminar el contenedor cuando hayas terminado de trabajar, usa:

```bash
docker-compose down
```

Esto eliminará el contenedor, pero el volumen `db` persistirá, manteniendo la información de la base de datos.

## Solución de Problemas

-   **El contenedor se detiene inmediatamente después de iniciar**:
    Asegúrate de que la contraseña del usuario `sa` cumple con los requisitos de complejidad de SQL Server (al menos 8 caracteres, mayúsculas, minúsculas y símbolos).

-   **No puedo conectarme desde mi cliente SQL**:
    Verifica que el puerto 1400 esté disponible y no esté siendo bloqueado por un firewall.

## Contribuciones

Si tienes sugerencias o encuentras algún problema, por favor abre un issue o envía un pull request.
