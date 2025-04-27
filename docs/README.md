> ⚠️ Documentación desactualizada, algunos componentes han cambiado

---

# Documentación de desarrollo del app

## Entorno de desarrollo

El entorno de desarrollo explora la implementación de diversas tecnologías que nos permitirán el correcto desarrollo de la aplicación móvil:

### IDE / Editor de texto

El entorno de desarrollo recomendado para la colaboración en creación de la app gira entorno a el uso de [Visual Studio Code](./manuales/vscode.md) y el IDE de [Android Studio](./manuales/android_studio.md), los cuales nos van a permitir el desarrollo correcto con múltiples herramientas y atajos para tanto la elaboración de código más rápido y la de compilación y debugging de la app en general.

- Ambos editores permiten el uso de extensiones, los cuales permiten el desarrollo con el código fuente (e.g. Javascript, Dart) mucho más fácil.

### Frontend

El frontend estará compuesto principalmente vía

- Framework: [Flutter](./manuales/flutter.md)
- Lenguaje: Dart
- Librerías:
  - flutter_launcher_icons
  - flutter_native_splash
  - …

### Backend

#### CRUD REST API y Web Socket Server para mensajería (Websockets)

- Framework: ExpressJS
- Lenguaje: Typescript ([NodeJS](./manuales/node.md))
- Librerías:
  - Express
  - Prisma
  - Websockets

### Deployment

- Azure
- Render
- Replit.io

### DBMS

- PostgreSQL

## Diagrama de despliegue

![](./Diagrama%20de%20Despliegue.png)

## Requerimientos no funcionales

# Requerimientos No Funcionales

- El sistema debe ser realizado con el lenguaje de programación multiplataforma **Dart** en el framework **Flutter SDK 3.24**.

- La aplicación debe ser compatible con **Android 10.0 o versiones superiores**.

- La interfaz de usuario debe ser **intuitiva y fácil de navegar**, con todas las funciones principales accesibles.

- Todo el desarrollo de la aplicación se llevará a cabo en equipos que utilicen el **sistema operativo Windows 10 en adelante**.

- El entorno de desarrollo para la aplicación será configurado utilizando **Visual Studio Code (VSCode)** como editor principal, con integración directa con **GitHub** para el control de versiones.

- El **IDE Android Studio** se utilizará para la emulación y pruebas de la aplicación en dispositivos Android, garantizando la compatibilidad con **Android 10.0 y versiones superiores**.

- Se utilizará un entorno de desarrollo en la nube proporcionado por **Replit**, donde se ejecutará un servidor en **Node.js con Express** para el backend de la aplicación.

- El backend estará vinculado a una base de datos **SQLite**, garantizando un almacenamiento ligero y eficiente de los datos necesarios para el funcionamiento de la aplicación.

- El sistema de autenticación de usuarios implementará el flujo **OAuth 2.0** proporcionado por **Google** mediante el backend de Supabase para el inicio de sesión y la recuperación de contraseña.

- La aplicación debe utilizar una paleta de colores consistente en todas las pantallas, asegurando que los colores seleccionados sigan las **pautas de accesibilidad** (como el contraste de texto) y mantengan la identidad visual del proyecto.

### Paleta de Colores:

- **Color primario**: Purple Heart `#4c36d3` y Cinnabar `#ea4335` (para botones principales y títulos).
- **Color de fondo**: Tuft Bush `#fedccd` (para fondos de pantalla).
- **Color de texto**: Gris oscuro `#000000` (para el texto principal).

## Diagrama de casos de uso

Los diagramas de caso de uso se pueden ver [aqui](./DiagramaCasosDeUso.plantuml)

<div style="text-align: center;">
   <img src="./Diagrama de casos de uso.png">
</div>

## Descripciones de casos de uso

- Iniciar Sesión: El usuario inicia sesion con su nombre de usuario y contraseña.

- Registrar nuevo usuario: En caso de no contar con una cuenta, el usuario debe crear una.

- Recuperar Contraseña: En caso de haber olvidado su contraseña, el usuario puede solicitar un reinicio de esta.

- Utilizar chat: Los usuarios compradores y vendedores deben poder mantener contacto mediante un sistema de chat.

- Cambiar credenciales: Los usuarios deben poder cambiar los datos asociados a su cuenta.

- Ver productos: Los usuarios deben poder navegar por elo catálogo de productos en venta.

- Filtrar productos: Los usuarios deben ser capaces de fltrar los productos segun ciertos criterios elegidos.

- Guardar productos en lista de deseados: Los productos deben poder ser guardados en la lista de facil acceso.

- Ver resultados personalizados: El sistema debe poder mostrar productos basados en las preferencias del usuario.

- Valorar productos: Los usuarios deben poder valorar los productos n un rango de 1 a 5 estrellas.

- Escribir reseña: Los usuarios deben poder ser capaces de escribir reseñas para los productos adquiridos.

- Subir imágenes a la reseña: Las reseñas deben admitir la carga de imagenes junto con el texto.

- Añadir productos al carrito: El usuatrio debe poder juntar los productos a comprar antes de realizar el pago conjunto.

- Realizar pago: EL usuario debe poder efectuar el pago de sus productos sin complicaciones.

- Seleccionar tipo de pago: El usuario podrá seleccionar el medio de pago a utilizar.

- Seleccionar lugar de entrega: El usuario debe poder seleccionar la direccion a donde se entregará el producto.

### Diagrama de base de datos

<div style="text-align: center;">
   <img src="./Diagrama de DBMS.png">
</div>

### Mockups

- [PDF con los mockups](./ProgMovil%20Mockups.pdf)
- Enlace al [figma](https://www.figma.com/design/58WawGjOo1lRGMM962pi8C/ProgMovil-Mockup?node-id=0-1&node-type=canvas&t=uGMNIACli6oW7iq9-0)
