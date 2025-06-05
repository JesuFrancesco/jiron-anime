# Jirón Anime Backend (Express + Prisma)

## Comandos de ejecución

0. llenar .env

```bash
code .env
# completar con credenciales indicadas en .env.example
```

1. Instalar dependencias

```bash
npm i
```

2. Generar bloat endpoints de Express

```bash
npm run express:generate
```

2. Generar clases Dart con ORM (opcional)

Nota. Hay problemas con el parseo de doubles, revisar los modelos generados en [la ruta de generación](../client/lib/model/entity/)

```bash
# 1. Descomentar dart generator en prisma/schema.prisma...

# 2. Correr
npm run dart:generate
```

3. Correr el programa (desarrollo)

```bash
npm run dev
```

---

## Ejecutar postgres local

```sh
# 1. crear docker
docker run --name janime_pg -e POSTGRES_PASSWORD=mypassword -p 5432:5432 -p 6543:6543 -v pgdata_janime:/var/lib/postgresql/data -d postgres:latest

# 2. copiar backup
docker cp backup/db_cluster-16-12-2024@14-20-34.backup janime_pg:/dump.backup

# 3. correr backup
docker exec -u postgres janime_pg psql -d postgres -f /dump.backup

# 4. Cambiar env de prisma por el de desarrollo

# Local
DATABASE_URL="postgresql://postgres:mypassword@localhost:5432/postgres?pgbouncer=true"
DIRECT_URL="postgresql://postgres:mypassword@localhost:5432/postgres"
```
