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

```bash
# 1. Descomentar dart generator en prisma/schema.prisma...

# 2. Correr
npm run dart:generate
```

3. Correr el programa (desarrollo)

```bash
npm run dev
```
