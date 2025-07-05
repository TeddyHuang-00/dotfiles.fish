# Check for necessary tool for running the script
for tool in git wget gum
    if not type -q $tool
        echo "$tool is not installed, please install it to continue" 1>&2
        exit 1
    end
end

# Reset the temporary environment variable
set -gx DOT_FILE_DEPS
set -gx DOT_FILE_CAVEATS

# Set the source configuration and script directories
set source_dir (path normalize ./config)
set script_dir (path normalize ./script)

# Set the config directory
set config_dir (path normalize ~/.config)
set backup_dir (path normalize ~/.backup/.config)

mkdir -p "$config_dir"
mkdir -p "$backup_dir"

# Styles for pretty printing
set width (math "min(80, $COLUMNS - 2)")
set gs_opt --align center --width $width --border rounded
set gs_error $gs_opt --border-foreground 1
set gs_success $gs_opt --border-foreground 2
set gs_warn $gs_opt --border-foreground 3
set gs_info $gs_opt --border-foreground 4
set gs_trace $gs_opt --border-foreground 8
set gs_text $gs_opt --align left --padding "1 3" --border double --border-foreground 7

function _install_config -a cfg_target
    set -l target_path (path normalize "$config_dir/$cfg_target")
    gum style $gs_info "Installing $cfg_target"

    # Check and backup if needed
    if test -d "$target_path"
        set -l backup_path (path normalize "$backup_dir/$cfg_target")

        gum style $gs_trace "Backing up"
        if test -d "$backup_path"
            if gum confirm "$backup_path already exists. Do you want to remove it?"
                gum style $gs_warn "Removing existing backup $backup_path"
                rm -rf "$backup_path"
            else
                gum style $gs_error "Keeping existing backup $backup_path"
                exit 1
            end
        end
        mv -fi "$target_path" "$backup_path"
    end

    # Copy the config directory
    if test -d (path resolve $source_dir/$cfg_target)
        gum style $gs_trace "Copying config"
        cp -r (path resolve $source_dir/$cfg_target) "$target_path"
    end

    # Run the post-install script
    if test -f "$script_dir/$cfg_target.fish"
        gum style $gs_trace "Running post-install script"
        source "$script_dir/$cfg_target.fish"
    end

    gum style $gs_success "Successfully installed $cfg_target"
end

# Create a list of available configurations with descriptions
set -l config_options
set -a config_options "fish (Shell configuration):fish"
set -a config_options "starship (Prompt configuration):starship"
set -a config_options "tmux (Terminal multiplexer):tmux"
set -a config_options "nvim (Neovim editor):nvim"
set -a config_options "jj (Jujutsu VCS):jj"
set -a config_options "git (Git configuration):git"
set -a config_options "delta (Git diff viewer):delta"
set -a config_options "bat (Cat replacement):bat"
set -a config_options "fastfetch (System information):fastfetch"
set -a config_options "tealdeer (CLI documentation):tealdeer"
set -a config_options "ghostty (Terminal emulator):ghostty"

# Add platform-specific configs
switch (uname -o)
    case GNU/Linux
        set -a config_options "zathura (PDF viewer):zathura"
    case Darwin
        set -a config_options "aerospace (Window manager):aerospace"
end

# Let user choose which configurations to install
set -l selected_options (gum choose --no-limit --header "Select Configurations to Install" --label-delimiter ":" $config_options)

# Check if any options were selected
if test (count $selected_options) -eq 0 -o -z "$selected_options"
    gum style $gs_error "No configurations selected"
    exit 0
end

# Extract config names from selections (remove descriptions)
set -l selected_configs
for option in $selected_options
    set -l config_name (string split " " $option)[1]
    set -a selected_configs "- $config_name"
end

# Show selected configurations and confirm
gum format -- "# Selected configurations" $selected_configs
echo

if not gum confirm "Do you want to proceed with installing these configurations?"
    gum style $gs_error "Installation cancelled"
    exit 0
end

# Install selected configurations
for config in $selected_options
    _install_config $config
end

gum style $gs_success "Finishing up"

# Check for dependencies
set -l deps (path sort -u $DOT_FILE_DEPS)
for dep in $deps
    set -l dep (string trim $dep)
    if not type -q $dep
        set -ga missing_deps "- $dep"
    end
end
if test (count $missing_deps) -gt 0
    gum style $gs_warn "Install these dependencies for full functionality:"

    gum format -- $missing_deps
end

if test (count $DOT_FILE_CAVEATS) -gt 0
    gum style $gs_info Caveats
    for caveat in $DOT_FILE_CAVEATS
        gum style $gs_text "$caveat"
    end
end

# Reset the temporary environment variable
set -gx DOT_FILE_DEPS
set -gx DOT_FILE_CAVEATS

# Reload the shell to apply changes
gum style $gs_success "Reloading shell to apply changes..."
exec fish
