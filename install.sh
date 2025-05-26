#!/bin/bash

# Kolory
green="\033[1;32m"
red="\033[1;31m"
yellow="\033[1;33m"
reset="\033[0m"

SCRIPT_NAME="dravfetch"
INSTALL_PATH="/usr/local/bin/$SCRIPT_NAME"
RAW_URL="https://raw.githubusercontent.com/Dravilias/DravFetch/main/dravfetch"

echo -e "${yellow}→ Sprawdzanie i instalacja zależności...${reset}"

# Figlet
if ! command -v figlet &> /dev/null; then
  echo -e "${yellow}→ Figlet nie znaleziony. Instaluję...${reset}"
  if command -v pacman &> /dev/null; then
    sudo pacman -Sy --noconfirm figlet
  elif command -v apt &> /dev/null; then
    sudo apt update && sudo apt install -y figlet
  elif command -v dnf &> /dev/null; then
    sudo dnf install -y figlet
  else
    echo -e "${red}✖ Nieznany menedżer pakietów. Zainstaluj figlet ręcznie.${reset}"
    exit 1
  fi
fi

# Pobierz skrypt
echo -e "${yellow}→ Pobieranie DravFetch...${reset}"
curl -sSL "$RAW_URL" -o "$SCRIPT_NAME" || {
  echo -e "${red}✖ Błąd pobierania skryptu.${reset}"
  exit 1
}

# Sprawdź czy nie pusty
if [[ ! -s "$SCRIPT_NAME" ]]; then
  echo -e "${red}✖ Błąd: Pobrany plik jest pusty lub nie istnieje.${reset}"
  exit 1
fi

# Instalacja
chmod +x "$SCRIPT_NAME"
sudo mv "$SCRIPT_NAME" "$INSTALL_PATH" || {
  echo -e "${red}✖ Nie udało się przenieść do $INSTALL_PATH.${reset}"
  exit 1
}

# Sukces
echo -e "${green}✓ Zainstalowano! Użyj komendy: ${reset}$SCRIPT_NAME"

# Nerd Fonts
echo -e "${yellow}→ Upewnij się, że Twój terminal używa czcionki Nerd Font${reset}"
echo -e "  🔤 Pobierz z: ${green}https://www.nerdfonts.com/${reset}"
echo -e "  ✨ Polecane: FiraCode, JetBrainsMono, Hack Nerd Font"

exit 0
