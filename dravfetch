#!/bin/bash

# Colors
bold=$(tput bold)
reset="\033[0m"
white="\033[1;37m"
yellow="\033[1;33m"
green="\033[0;32m"
blue="\033[1;34m"
darkblue="\033[0;34m"
magenta="\033[0;35m"
red="\033[1;31m"

# Indent (spaces)
indent="  "

# Get distro color
get_distro_color() {
  local distro_name
  distro_name=$(source /etc/os-release && echo "$ID")

  case "$distro_name" in
    ubuntu|debian) echo "\033[1;31m" ;;
    fedora) echo "\033[0;36m" ;;
    arch) echo "\033[1;34m" ;;
    manjaro|opensuse) echo "\033[0;32m" ;;
    centos|rhel) echo "\033[0;31m" ;;
    alpine) echo "\033[1;36m" ;;
    *) echo "\033[1;37m" ;;
  esac
}

distro_color=$(get_distro_color)

# Distro name ASCII with indent
echo -e "${indent}${distro_color}${bold}"
figlet -f smslant "$(source /etc/os-release && echo $NAME | awk '{print $1}')" | sed "s/^/${indent}/"
echo -e "${indent}${reset}"

# Get colored values
user="${yellow}$(whoami)${reset}"
distro="${distro_color}$(source /etc/os-release && echo "$PRETTY_NAME")${reset}"
kernel="${blue}$(uname -r)${reset}"
uptime="${green}$(uptime -p | cut -d ' ' -f2-)${reset}"
shell="${magenta}$(basename "$SHELL")${reset}"
memory="${red}$(free -m | awk '/Mem:/ {print $3 " / " $2 " MiB"}')${reset}"

# Colors line (8 color dots)
color_dots=""
for i in {0..7}; do
  color_dots+="\033[3${i}m●\033[0m "
done
colors="${color_dots% }"

# Labels and values with color on labels as well
labels=(
  "${yellow}  User${reset}"
  "${distro_color}󰻀  Distro${reset}"
  "${blue}󰌢  Kernel${reset}"
  "${green}  Uptime${reset}"
  "${magenta}  Shell${reset}"
  "${red}  Memory${reset}"
  "${white}  Colors${reset}"
)

values=(
  "$user"
  "$distro" 
  "$kernel" 
  "$uptime" 
  "$shell" 
  "$memory" 
  "$colors"
  )

# Function to strip ANSI escape codes
strip_ansi() {
  echo -e "$1" | sed 's/\x1b\[[0-9;]*m//g'
}

# Calculate max label length (without ANSI codes)
max_label=0
for label in "${labels[@]}"; do
  plain_label=$(strip_ansi "$label")
  (( ${#plain_label} > max_label )) && max_label=${#plain_label}
done

box_width=$((max_label + 2))

# Draw top border with indent
echo -e "${indent}${white}╭$(printf '─%.0s' $(seq 1 $box_width))╮${reset}"

# Print each label inside box and value outside, aligned properly with indent
for i in "${!labels[@]}"; do
  plain_label=$(strip_ansi "${labels[$i]}")
  padding=$((max_label - ${#plain_label}))
  printf "${indent}${white}│ %b%*s │${reset} %b\n" "${labels[$i]}" "$padding" "" "${values[$i]}"
done

# Draw bottom border with indent
echo -e "${indent}${white}╰$(printf '─%.0s' $(seq 1 $box_width))╯${reset}"
