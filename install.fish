# Set the config directory
set -l config_dir (path normalize ~/.config/fish)

# Check and backup if needed
if test -d $config_dir
    echo "Backing up existing config to fish.bak"
    mv $config_dir $config_dir.bak
end

# Copy the config directory
echo "Copying config to $config_dir"
mkdir -p $config_dir
cp -r ./config $config_dir

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
