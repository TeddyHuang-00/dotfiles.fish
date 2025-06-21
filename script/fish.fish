# Install plugins
if type -q fisher
    echo "Using system-wide fisher installation"
else
    echo "Installing fisher first"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end
echo "Installing plugins"
cat (path resolve ~/.config/fish/fish_plugins) | fisher install

# Set theme
fish_config theme save "Catppuccin Mocha"

# Success message
echo "Fish shell configuration installed successfully!"

# Export dependency
set -gxa DOT_FILE_DEPS nvim bat starship carapace fzf zoxide uv bun
