import app from "./app";

const port = 8080;

// == Entry point
app.listen(port, () => {
  console.log("Servidor iniciado en el puerto:", port);
  console.log(`Escuchando en http://0.0.0.0:${port}`);
});
