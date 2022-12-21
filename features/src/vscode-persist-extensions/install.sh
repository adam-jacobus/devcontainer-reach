#!/usr/bin/env bash

set -e

USERNAME="${USERNAME:-"automatic"}"

if [ "$(id -u)" -ne 0 ]; then
  echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
  exit 1
fi

# If in automatic mode, determine if a user already exists, if not use vscode
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
  USERNAME="${_REMOTE_USER}"
elif [ "${USERNAME}" = "none" ]; then
  USERNAME=root
fi

# Make directories
echo "Making VSCode directories for ${USERNAME}..."

if [ "${USERNAME}" = "root" ]; then
  PREFIX="/root"
else
  PREFIX="/home/${USERNAME}"
fi

mkdir -p "${PREFIX}/.vscode-server/extensions" "${PREFIX}/.vscode-server-insiders/extensions"
chown -R $USERNAME "${PREFIX}/.vscode-server" "${PREFIX}/.vscode-server-insiders"

echo "VSCode directories created!"