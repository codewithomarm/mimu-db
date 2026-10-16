# MIMU — entorno local de base de datos (v1.3 MVP)

Este paquete levanta PostgreSQL y pgAdmin mediante Docker Compose. La base usa el esquema MIMU v1.3: identificadores UUIDv7 generados por la API y nombres de tablas/columnas/tipos en inglés.

> Entorno de desarrollo universitario local. No es una configuración de producción.

## Requisitos

- Docker Desktop instalado y en ejecución (incluye Docker Compose).
- Git para clonar el repositorio.
- Puertos locales disponibles: `5432` (PostgreSQL) y `5050` (pgAdmin), configurables en `.env`.

## 1. Configurar el entorno

Desde la raíz de este directorio:

### Windows PowerShell

```powershell
Copy-Item .env.example .env
```

### macOS / Linux

```bash
cp .env.example .env
```

Edita `.env` y cambia los tres secretos de ejemplo: `POSTGRES_PASSWORD`, `API_DB_PASSWORD` y `PGADMIN_PASSWORD`. Para un trabajo en equipo, cada desarrollador debe crear su propio `.env`; no se debe subir al repositorio.

## 2. Iniciar los contenedores

```bash
docker compose up -d
```

Comprobar el estado:

```bash
docker compose ps
docker compose logs -f postgres
```

El esquema y el usuario de la API se crean automáticamente solo cuando PostgreSQL inicializa por primera vez un volumen de datos vacío. Los scripts se ejecutan en orden: crear el rol de API, instalar el esquema y conceder permisos.

## 3. Abrir pgAdmin

Abre [http://localhost:5050](http://localhost:5050) e inicia sesión con `PGADMIN_EMAIL` y `PGADMIN_PASSWORD` definidos en `.env`.

Registra un servidor en pgAdmin:

- **General / Name:** `MIMU Local`
- **Connection / Host name/address:** `postgres`
- **Port:** `5432`
- **Maintenance database:** `mimu`
- **Username:** `mimu_admin`
- **Password:** el valor de `POSTGRES_PASSWORD`

El host `postgres` funciona desde el contenedor de pgAdmin porque es el nombre del servicio dentro de la red Compose. Si conectas una herramienta instalada directamente en el equipo, utiliza `localhost`, puerto `5432`.

## 4. Conectar la API

Si la API se ejecuta directamente en el equipo, utiliza las siguientes variables (o sus equivalentes en el framework):

```dotenv
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=mimu
DATABASE_USER=mimu_app
DATABASE_PASSWORD=<valor de API_DB_PASSWORD>
```

Si la API se ejecuta como otro servicio de este mismo Compose, utiliza `DATABASE_HOST=postgres` y `DATABASE_PORT=5432`.

La URL de conexión habitual es:

```text
postgresql://mimu_app:<API_DB_PASSWORD>@localhost:5432/mimu
```

Sustituye el marcador por la contraseña real; no guardes secretos en el código fuente. El usuario `mimu_app` tiene permisos de lectura/escritura de datos, no permisos de administración del esquema.

Android y Web deben conectarse a la API, nunca directamente a PostgreSQL. Si la API corre en el equipo anfitrión en el puerto `8000`, la Web puede usar `http://localhost:8000` y el emulador Android estándar `http://10.0.2.2:8000` (si el puerto o el tipo de emulador cambian, ajusta la URL).

## 5. Comandos útiles

```bash
# Detener contenedores sin borrar los datos
docker compose down

# Volver a iniciar
docker compose up -d

# Ver logs de PostgreSQL
docker compose logs -f postgres

# Abrir psql como administrador
docker compose exec postgres psql -U mimu_admin -d mimu

# Verificar la versión
docker compose exec postgres psql -U mimu_admin -d mimu -c "SELECT version();"
```

## 6. Reinicializar la base de datos (DESTRUCTIVO)

Solo si no necesitas conservar ningún dato local:

```bash
docker compose down -v
docker compose up -d
```

`down -v` elimina el volumen de PostgreSQL y el volumen de pgAdmin; se perderán los datos de ambos. No lo uses como comando normal para detener el proyecto.

## 7. Cambios de esquema después del primer arranque

Los scripts de `/docker-entrypoint-initdb.d/` se ejecutan solo cuando el directorio de datos está vacío. Editar `01-schema.sql` y ejecutar otra vez `docker compose up -d` **no** actualiza una base ya inicializada.

Para desarrollo colaborativo, los cambios posteriores deben convertirse en migraciones SQL numeradas y versionadas, ejecutadas de forma controlada. No borres el volumen para aplicar una migración si existen datos que deban conservarse.

## 8. Estructura del paquete

```text
MIMU_local_database_v1.3/
├── compose.yaml
├── .env.example
├── .gitignore
├── README.md
├── database/
│   ├── MIMU_postgresql_schema_v1.3_MVP.sql
│   └── init/
│       ├── 00-create-runtime-role.sql
│       ├── 01-schema.sql
│       └── 02-grant-runtime-permissions.sql
└── docs/
    └── MIMU_diseno_tecnico_ERD_v1.3_MVP.md
```

## Nota sobre el esquema

El esquema base no incluye usuarios, estudiantes, roles ni permisos de demostración. Las tablas `roles`, `permissions` y sus relaciones quedan vacías hasta que el equipo apruebe y añada una migración de datos iniciales. La API debe generar cada UUIDv7 y enviarlo explícitamente en los `INSERT`.
