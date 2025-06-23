# Fish settings
set -gx fish_greeting

# Common options
set -gx EDITOR nvim
set -gx MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
set -gx TERM xterm-256color

# Carapace settings
set -gx CARAPACE_BRIDGES 'zsh,fish,bash,clap,inshellisense'
set -gx CARAPACE_MATCH 1
set -gx CARAPACE_EXCLUDES brew

# Vox settings
set -gx VOX_VENV_DIR ~/Venv

# Starship setting
set -gx STARSHIP_CONFIG ~/.config/starship/config.toml

# Hyprland - nvidia compatibility settings
if type -q hyprland; and test -n "$(lspci | grep -i nvidia)"
    set -gx WLR_RENDERER_ALLOW_SOFTWARE 1
end
