set -l config_dir (path resolve ~/.config/zathura)

# Download the themes
wget -P "$config_dir" https://github.com/catppuccin/zathura/raw/main/src/catppuccin-latte
wget -P "$config_dir" https://github.com/catppuccin/zathura/raw/main/src/catppuccin-frappe
wget -P "$config_dir" https://github.com/catppuccin/zathura/raw/main/src/catppuccin-macchiato
wget -P "$config_dir" https://github.com/catppuccin/zathura/raw/main/src/catppuccin-mocha

# Export dependency
set -gxa DOT_FILE_DEPS zathura
