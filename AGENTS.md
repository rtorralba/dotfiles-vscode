# AGENTS.md

Este repositorio contiene la configuración de dotfiles que se usa dentro de un devcontainer de VSCode. Sirve para dejar el entorno de trabajo (extensiones recomendadas, settings de VSCode, configuración de phpactor, etc.) listo cada vez que se levanta un nuevo devcontainer.

## Estructura

- `setup`: script que se ejecuta para preparar el workspace dentro del devcontainer.
- `.vscode/extensions.json`: lista de extensiones **recomendadas** para el workspace.
- `.vscode/settings.json`: settings de VSCode/PHP/phpactor para el workspace.
- `.config/phpactor`: configuración de phpactor, enlazada por símlink al `$HOME/.config` del container.

## Qué hace el script `setup`

1. Limpia la carpeta `.vscode/` del workspace (`rm -rf`).
2. Copia `extensions.json` y `settings.json` desde `$HOME/dotfiles/.vscode` al workspace (`$WORKSPACE_FOLDER/.vscode`).
3. Crea `$HOME/.config` y enlaza por símlink la configuración de phpactor (`$HOME/dotfiles/.config/phpactor` -> `$HOME/.config/phpactor`).
4. Si el comando `code` está disponible en el `PATH`, instala automáticamente (con `code --install-extension`) cada extensión listada en `extensions.json`. Si `code` no está disponible, se salta este paso y lo avisa por consola.

## Instalación de las extensiones recomendadas

El script `setup` intenta instalar automáticamente las extensiones listadas en `.vscode/extensions.json` usando el CLI `code --install-extension`, siempre que ese comando esté disponible en el `PATH` del devcontainer.

Si el comando `code` no está disponible (por ejemplo, porque el shim de VSCode Remote todavía no se ha inyectado en el `PATH` en ese momento), hay que instalarlas manualmente:

1. Abrir la paleta de comandos (`Ctrl+Shift+P` / `Cmd+Shift+P`).
2. Ejecutar el comando **"Extensions: Show Recommended Extensions"** (Extensiones: Mostrar extensiones recomendadas).
3. En el panel de extensiones que se abre, pulsar **"Install Workspace Recommended Extensions"** (o instalarlas una a una si se prefiere).

## Normas de trabajo en este repositorio

- **Documentar siempre todos los cambios**: cualquier cambio que se haga en este proyecto (script `setup`, settings, extensiones recomendadas, estructura de carpetas, etc.) debe reflejarse también en este `AGENTS.md`, manteniéndolo como fuente de verdad actualizada sobre cómo funciona el repositorio.
