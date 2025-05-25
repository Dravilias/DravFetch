#!/bin/bash

# Colors
green="\033[1;32m"
red="\033[1;31m"
yellow="\033[1;33m"
reset="\033[0m"

SCRIPT_NAME="dravfetch"
INSTALL_PATH="/usr/local/bin/$SCRIPT_NAME"
RAW_URL="https://raw.githubusercontent.com/Dravilias/DravFetch/main/dravfetch"

# Check for curl
if ! command -v curl &> /dev/null; then
  echo -e "${red}✖ 'curl' is not installed. Please install it and rerun this script.${reset}"
  exit 1
fi

# Check for sudo
if ! command -v sudo &> /dev/null; then
  echo -e "${red}✖ 'sudo' is required. Please run as root or install sudo.${reset}"
  exit 1
fi

echo -e "${yellow}→ Downloading DravFetch...${reset}"

curl -sSL "$RAW_URL" -o "$SCRIPT_NAME" || {
  echo -e "${red}✖ Failed to download script.${reset}"
  exit 1
}

chmod +x "$SCRIPT_NAME" || {
  echo -e "${red}✖ Failed to make script executable.${reset}"
  exit 1
}

sudo mv "$SCRIPT_NAME" "$INSTALL_PATH" || {
  echo -e "${red}✖ Failed to move script to $INSTALL_PATH.${reset}"
  exit 1
}

echo -e "${green}✓ Installed as '$SCRIPT_NAME'. You can now run it with: $SCRIPT_NAME${reset}"

# Optional: Add to shell startup
read -rp "$(echo -e "${yellow}→ Add DravFetch to your shell startup? (y/n): ${reset}")" reply
if [[ "$reply" =~ ^[Yy]$ ]]; then
  shell_rc=""
  case "$SHELL" in
    */zsh) shell_rc="$HOME/.zshrc" ;;
    */bash) shell_rc="$HOME/.bashrc" ;;
  esac

  if [[ -n "$shell_rc" ]]; then
    if ! grep -q "$SCRIPT_NAME" "$shell_rc"; then
      echo "$SCRIPT_NAME" >> "$shell_rc"
      echo -e "${green}✓ Added to $shell_rc${reset}"
    else
      echo -e "${yellow}→ Already present in $shell_rc${reset}"
    fi
  else
    echo -e "${red}✖ Could not detect shell config file.${reset}"
  fi
fi

echo -e "${yellow}→ To uninstall: sudo rm $INSTALL_PATH${reset}"
