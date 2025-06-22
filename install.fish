# Check for necessary tool for running the script
for tool in git wget
    if not type -q $tool
        echo "$tool is not installed, please install it to continue"
        exit 1
    end
end

# Reset the temporary environment variable
set -gx DOT_FILE_DEPS
set -gx DOT_FILE_CAVEATS

# Set the source configuration and script directories
set -g source_dir (path normalize ./config)
set -g script_dir (path normalize ./script)

# Set the config directory
set -g config_dir (path normalize ~/.config)
set -g backup_dir (path normalize ~/.backup/.config)

mkdir -p "$config_dir"
mkdir -p "$backup_dir"

function _pretty_print -a message -a level
    switch $level
        case 1
            set -f symbol =
            set -f color green
        case 2
            set -f symbol -
            set -f color blue
        case *
            set -f symbol " "
            set -f color normal
    end

    set -l str_len (string length --visible $message)
    set -l pad_left (math "round ((60 - $str_len) / 2)")
    set -l pad_right (math "(60 - $str_len) - $pad_left")
    (set_color $color)
    printf "%s" (string repeat -m $pad_left $symbol)
    (set_color normal)
    printf " %s " $message
    (set_color $color)
    printf "%s" (string repeat -m $pad_right $symbol)
    (set_color normal)
    echo
end

function _install_config -a cfg_target
    set -l target_path (path normalize "$config_dir/$cfg_target")
    _pretty_print "Installing $cfg_target" 1

    # Check and backup if needed
    if test -d "$target_path"
        set -l backup_path (path normalize "$backup_dir/$cfg_target")

        _pretty_print "Backing up" 2
        if test -d "$backup_path"
            read -P "$backup_path already exists. Do you want to remove it? [y/N] " confirm
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
    if test -d (path resolve $source_dir/$cfg_target)
        _pretty_print "Copying config" 2
        cp -r (path resolve $source_dir/$cfg_target) "$target_path"
    end

    # Run the post-install script
    if test -f "$script_dir/$cfg_target.fish"
        _pretty_print "Running post-install script" 2
        source "$script_dir/$cfg_target.fish"
    end
end

# Shell and prompt
_install_config fish
_install_config starship

# VCS and tools
_install_config jj
_install_config git
_install_config delta
_install_config bat

# Terminal
_install_config ghostty
_install_config tmux

# Editor
_install_config nvim

# Platform specific dotfiles
switch (uname -o)
    case GNU/Linux
        # Linux-specific dotfiles
        _install_config zathura
    case Darwin
        # macOS-specific dotfiles
        _install_config aerospace
    case '*'
        # Other platforms
end

_pretty_print "Finishing up" 1
_pretty_print Dependencies 2

# Check for dependencies
set -l deps (path sort -u $DOT_FILE_DEPS)
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

_pretty_print Caveats 2

if test (count $DOT_FILE_CAVEATS) -gt 0
    for caveat in $DOT_FILE_CAVEATS
        echo (set_color blue) "=>" (set_color normal) "$caveat"
    end
end

# Reset the temporary environment variable
set -gx DOT_FILE_DEPS
set -gx DOT_FILE_CAVEATS

# Reload the shell to apply changes
echo "Reloading shell to apply changes..."
exec fish
