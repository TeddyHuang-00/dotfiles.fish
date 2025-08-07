set -l config_dir (path resolve ~/.config/jjui)

# Make sure the themes directory exists
mkdir -p "$config_dir/themes"

# Download the themes
wget -P "$config_dir/themes" https://github.com/vic/tinted-jjui/raw/main/themes/base24-catppuccin-latte.toml
wget -P "$config_dir/themes" https://github.com/vic/tinted-jjui/raw/main/themes/base24-catppuccin-frappe.toml
wget -P "$config_dir/themes" https://github.com/vic/tinted-jjui/raw/main/themes/base24-catppuccin-macchiato.toml
wget -P "$config_dir/themes" https://github.com/vic/tinted-jjui/raw/main/themes/base24-catppuccin-mocha.toml

# Check if delta is installed
if not type -q delta
    set -gxa DOT_FILE_CAVEATS "delta is not installed, please install it to make sure the custom diff works"
end

# Export dependency
set -gxa DOT_FILE_DEPS jjui delta
