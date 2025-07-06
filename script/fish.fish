# Install plugins
set -l plugins (cat (path resolve ~/.config/fish/fish_plugins))
if type -q fisher
    echo "Using system-wide fisher installation"
else
    echo "Installing fisher first"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end
echo "Installing plugins"
echo $plugins | fisher install

# Set theme
yes | fish_config theme save "Catppuccin Mocha"

set -gxa DOT_FILE_CAVEATS "Start a new fish session or run `exec fish` to apply changes."

# Export dependency
set -gxa DOT_FILE_DEPS nvim bat starship carapace fzf zoxide uv bun
