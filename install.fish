# Set the config directory
set -l config_dir (path normalize ~/.config)
set -l backup_dir (path normalize ~/.config.bak)
set -l cfg_target fish
set -l deps nvim bat starship carapace fzf zoxide uv bun

# Check and backup if needed
if test -d "$config_dir/$cfg_target"
    echo "Backing up existing config to $backup_dir"
    mkdir -p $backup_dir
    if test -d "$backup_dir/$cfg_target"
        read -P "Backup directory already exists. Do you want to remove it? [y/N] " confirm
        if test "$confirm" = y -o "$confirm" = Y
            echo "Removing existing backup directory $backup_dir/$cfg_target"
            rm -rf "$backup_dir/$cfg_target"
        else
            echo "Keeping existing backup directory $backup_dir/$cfg_target"
            exit 1
        end
    end
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

# Check for dependencies
for dep in $deps
    set -l dep (string trim $dep)
    if not type -q $dep
        set -ga missing_deps $dep
    end
end
if test (count $missing_deps) -gt 0
    echo "Install the dependencies below for full functionality:"
    for dep in $missing_deps
        echo " - $dep"
    end
end

# Reload the shell to apply changes
echo "Reloading shell to apply changes..."
exec fish
