# AGENTS.md

Este repositorio contiene la configuración de dotfiles que se usa dentro de un devcontainer de VSCode. Sirve para dejar el entorno de trabajo (extensiones recomendadas, settings de VSCode, PHPantom como servidor de lenguaje PHP, etc.) listo cada vez que se levanta un nuevo devcontainer.

## Estructura

- `setup`: script que se ejecuta para preparar el workspace dentro del devcontainer.
- `install-extensions.sh`: script que instala (con `code --install-extension`) todas las extensiones listadas en `.vscode/extensions.json`. Está pensado para ejecutarse a mano desde la terminal, no desde `setup` (ver más abajo el motivo).
- `.vscode/extensions.json`: lista de extensiones **recomendadas** para el workspace.
- `.vscode/settings.json`: settings de VSCode/PHP (formateador por defecto de PHP: PHPantom) para el workspace.
- `.vscode/*.code-snippets`: snippets de workspace (por ejemplo `.vscode/php.code-snippets`). `setup` los enlaza a la carpeta de snippets de usuario de VSCode (ver más abajo); no requieren configuración en `settings.json`.

## Qué hace el script `setup`

1. Elimina la carpeta `.vscode/` del workspace (`rm -rf`).
2. Enlaza por símlink `$HOME/dotfiles/.vscode` -> `$WORKSPACE_FOLDER/.vscode`, de modo que cualquier fichero nuevo de `.vscode/` (settings, extensiones, snippets...) llega al workspace sin copiarlo uno a uno. Como es un enlace, los cambios hechos desde el workspace se escriben directamente en los dotfiles.
3. Enlaza por símlink cada `$HOME/dotfiles/.vscode/*.code-snippets` en `$HOME/.vscode-server/data/User/snippets/` (snippets a nivel de usuario). Se hace porque VSCode no detectaba los snippets de workspace a través del símlink de `.vscode`; así se cargan siempre, sea cual sea el workspace.
4. Añade (si no existe ya) un alias `install-extensions` en `$HOME/.bashrc` que ejecuta `$HOME/dotfiles/install-extensions.sh` con el `$WORKSPACE_FOLDER` correcto.

## Instalación de las extensiones recomendadas

En el momento en que se ejecuta `setup` (al crearse el devcontainer), el CLI `code` todavía no está disponible en el `PATH`: el shim de VSCode Remote se inyecta más tarde, cuando VSCode termina de conectarse al contenedor. Por eso `setup` **no** puede instalar las extensiones directamente con un `for` en ese punto.

En su lugar, `setup` deja preparado un alias `install-extensions` (definido en `$HOME/.bashrc`) que apunta al script `install-extensions.sh` de este repo. Una vez que VSCode ya está conectado y `code` está disponible en el `PATH`, basta con abrir una terminal nueva (o hacer `source $HOME/.bashrc`) y ejecutar:

```
install-extensions
```

Esto instala todas las extensiones listadas en `.vscode/extensions.json` del workspace.

Alternativamente, también se pueden instalar desde la UI de VSCode:

1. Abrir la paleta de comandos (`Ctrl+Shift+P` / `Cmd+Shift+P`).
2. Ejecutar el comando **"Extensions: Show Recommended Extensions"** (Extensiones: Mostrar extensiones recomendadas).
3. En el panel de extensiones que se abre, pulsar **"Install Workspace Recommended Extensions"** (o instalarlas una a una si se prefiere).

## Normas de trabajo en este repositorio

- **Documentar siempre todos los cambios**: cualquier cambio que se haga en este proyecto (script `setup`, settings, extensiones recomendadas, estructura de carpetas, etc.) debe reflejarse también en este `AGENTS.md`, manteniéndolo como fuente de verdad actualizada sobre cómo funciona el repositorio.
