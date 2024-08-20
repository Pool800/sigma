#!/bin/bash

# Ensure script is run as root
if [ "$(id -u)" -ne "0" ]; then
    echo "This script must be run as root. Exiting."
    exit 1
fi

# Remove existing Waybar configuration
echo "Removing existing Waybar configuration..."
rm -rf /root/.config/waybar

# Uninstall Waybar
echo "Uninstalling Waybar..."
pacman -Rns --noconfirm waybar

# Reinstall Waybar
echo "Reinstalling Waybar..."
pacman -S --noconfirm waybar

# Create fresh configuration files
echo "Creating fresh Waybar configuration files..."
mkdir -p /root/.config/waybar

# Create and write to config file
cat <<EOL > /root/.config/waybar/config
{
  "layer": "top",
  "position": "top",
  "modules-left": ["sway/workspaces", "clock"],
  "modules-center": [],
  "modules-right": ["tray", "sway/mode"],
  "tray-padding": 2,
  "separator": false
}
EOL

# Create and write to style file
cat <<EOL > /root/.config/waybar/style.css
* {
  font-family: "monospace";
  font-size: 12px;
  background: #1d1f21;
  color: #c5c8c6;
}

#clock {
  margin-right: 10px;
}
EOL

# Inform user
echo "Waybar has been reinstalled and configured. Please restart Sway to apply the changes."