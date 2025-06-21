set -l config_dir (path resolve ~/.config/delta)

# Make sure the themes directory exists
mkdir -p "$config_dir/themes"

# Download the themes

wget -P "$config_dir/themes" https://github.com/catppuccin/delta/raw/main/catppuccin.gitconfig

# Export dependency
set -gxa DOT_FILE_DEPS delta
