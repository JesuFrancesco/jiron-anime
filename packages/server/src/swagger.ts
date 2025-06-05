import swaggerJsdoc, { Options } from "swagger-jsdoc";
import { readdirSync, statSync } from "fs";
import { join } from "path";
import { listAllRoutesFlat } from "./router";

// Obtener todos los directorios en src/generated
const generatedPath = join(__dirname, "./generated/express");
const directories = readdirSync(generatedPath).filter((file) =>
  statSync(join(generatedPath, file)).isDirectory()
);

// Generar la descripción con la lista de directorios
const description =
  `API de Jiron Anime, recuerda usar los endpoints con /api/v1. **(e.g. GET /api/v1/Order)**

API_ROUTER es un router de Express que contiene las siguientes rutas:
${listAllRoutesFlat()
  .map((route) => `- ${route}`)
  .join("\n")}

Entidades mapeadas en src/generated:\n\n` +
  directories.map((dir) => `- ${dir}`).join("\n");

const options = {
  apis: ["./router/index.ts"],
  basePath: "/",
  swaggerDefinition: {
    info: {
      version: "1.0.0",
      title: "Jiron Anime API",
      description,
    },
  },
} satisfies Options;

export const specs = swaggerJsdoc(options);
