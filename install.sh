#!/bin/bash

# Kolory
green="\033[1;32m"
red="\033[1;31m"
yellow="\033[1;33m"
reset="\033[0m"

NAME="dravfetch"
INSTALL_PATH="/usr/local/bin/$NAME"
RAW_URL="https://raw.githubusercontent.com/Dravilias/DravFetch/main/dravfetch"

echo -e "${yellow}→ Sprawdzanie i instalacja zależności...${reset}"

# Sprawdzenie i instalacja figlet
if ! command -v figlet &> /dev/null; then
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

echo -e "${yellow}→ Pobieranie DravFetch...${reset}"
curl -sSL "$RAW_URL" -o "$NAME" || {
  echo -e "${red}✖ Błąd pobierania skryptu.${reset}"
  exit 1
}

if [[ ! -s "$NAME" ]]; then
  echo -e "${red}✖ Plik jest pusty. Coś poszło nie tak z pobieraniem.${reset}"
  exit 1
fi

chmod +x "$NAME"
sudo mv "$NAME" "$INSTALL_PATH" || {
  echo -e "${red}✖ Nie udało się przenieść do $INSTALL_PATH.${reset}"
  exit 1
}

echo -e "${green}✓ Zainstalowano! Uruchom za pomocą: ${reset}$NAME"

# Informacja o czcionkach Nerd Font
echo -e "${yellow}→ WAŻNE: Użyj terminala z ustawioną czcionką Nerd Font${reset}"
echo -e "  📥 Pobierz czcionkę: ${green}https://www.nerdfonts.com/${reset}"
echo -e "  🎨 Polecane: FiraCode Nerd Font, JetBrainsMono Nerd Font"

exit 0
