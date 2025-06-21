set -l config_dir (bat --config-dir)

# Make sure the themes directory exists
mkdir -p "$config_dir/themes"

# Download the themes
wget -P "$config_dir/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
wget -P "$config_dir/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
wget -P "$config_dir/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$config_dir/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme

# Build the cache
if type -q bat
    bat cache --build
else
    set -gxa DOT_FILE_CAVEATS "bat is not installed, please run 'bat cache --build' manually"
end

# Export dependency
set -gxa DOT_FILE_DEPS bat
