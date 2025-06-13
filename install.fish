# Set the config directory
set -l config_dir (path normalize ~/.config)
set -l backup_dir (path normalize ~/.config.bak)
set -l cfg_target fish

# Check and backup if needed
if test -d "$config_dir/$cfg_target"
    echo "Backing up existing config to $backup_dir"
    mkdir -p $backup_dir
    mv -fi "$config_dir/$cfg_target" "$backup_dir"
end

# Copy the config directory
echo "Copying config to $config_dir/$cfg_target"
mkdir -p "$config_dir/$cfg_target"
cp -r ./config/* "$config_dir/$cfg_target"

# Install plugins
if type -q fisher
    echo "Using system-wide fisher installation"
else
    echo "Installing fisher first"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end
echo "Installing plugins"
cat fish_plugins | fisher install

# Set theme
fish_config theme save "Catppuccin Mocha"

# Success message
echo "Fish shell configuration installed successfully!"
exec fish -l