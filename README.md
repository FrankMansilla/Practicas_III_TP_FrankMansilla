# Practicas Profesionalizantes III - Frank Mansilla

Este proyecto contiene una aplicacion sencilla de python con flask 

## Levantar el Proyecto con Python

1. **Crear y Activar Entorno Virtual:**
   - Ejecuta el siguiente comando para crear un entorno virtual:
     ```
     python -m venv venv
     ```

   - Activa el entorno virtual:
     - En Windows:
       ```
       .\venv\Scripts\activate
       ```
     - En Linux/Mac:
       ```
       source venv/bin/activate
       ```

2. **Ejecutar el Proyecto con Python:**
   - Ejecuta el siguiente comando para iniciar el proyecto:
     ```
     python <app.py>
     ```

## Levantar el Proyecto con Docker

- Ejecuta el siguiente comando para iniciar el proyecto con Docker:
    ```
    docker-compose up
    ```



## GitHub Actions

### Verificación del Estado del Proyecto

- El primer workflow de GitHub Actions verifica el estado del proyecto. Este flujo de trabajo está basado en la documentación oficial de GitHub.

### Confirmación del Programa en el Puerto 3359

- El segundo workflow de GitHub Actions se encarga de confirmar que el programa se levanta correctamente en el puerto 3359.

## Hooks

### Pre-commit

- El hook pre-commit verifica que el archivo "requeriments.txt" no tenga más de 12 líneas de código antes de realizar el commit. Si excede este límite, el commit se cancela.

### Post-commit

- Mientras estás en la rama `Develop` al realizar un commit, el hook post-commit realiza automáticamente un push a la rama `origin/develop`.

---

