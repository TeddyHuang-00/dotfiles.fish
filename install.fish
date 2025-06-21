# Set the config directory
set -g config_dir (path normalize ~/.config)
set -g backup_dir (path normalize ~/.config.bak)

mkdir -p "$config_dir"
mkdir -p "$backup_dir"

function _backup_and_copy_config -a cfg_target
    set -l target_path (path normalize "$config_dir/$cfg_target")

    # Check and backup if needed
    if test -d "$target_path"
        set -l backup_path (path normalize "$backup_dir/$cfg_target")

        echo "Backing up $target_path to $backup_path"
        if test -d "$backup_path"
            read -P "Backup directory already exists. Do you want to remove it? [y/N] " confirm
            if test "$confirm" = y -o "$confirm" = Y
                echo "Removing existing backup directory $backup_path"
                rm -rf "$backup_path"
            else
                echo "Keeping existing backup directory $backup_path"
                exit 1
            end
        end
        mv -fi "$target_path" "$backup_path"
    end

    # Copy the config directory
    echo "Copying config to $target_path"
    cp -r (path resolve ./config/$cfg_target) "$target_path"
end

_backup_and_copy_config fish

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
set -l deps nvim bat starship carapace fzf zoxide uv bun

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
