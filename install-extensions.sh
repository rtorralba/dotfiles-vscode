#!/bin/bash

if ! command -v code &> /dev/null; then
    echo "'code' command not found in PATH, cannot install extensions"
    exit 1
fi

echo "Installing recommended extensions from extensions.json"
for extension in $(grep -oP '"\K[\w-]+\.[\w-]+(?=")' "$WORKSPACE_FOLDER/.vscode/extensions.json"); do
    code --install-extension "$extension" --force
done
