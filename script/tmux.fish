# Install TPM
if test -d ~/.tmux/plugins/tpm
    echo "TPM is already installed. Skipping..."
else
    mkdir -p ~/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
end

# Update the shell path
set -l fish_path (which fish)
set -l config_path (path resolve ~/.config/tmux/tmux.conf)
set -l config_content "$(cat $config_path)"
string replace -a __FISH_SHELL_PATH__ "$fish_path" $config_content >$config_path

# Finish the install in tmux
set -gxa DOT_FILE_CAVEATS "Please finish the install in tmux by running <Ctrl-a> + I"

# Export dependency
set -gxa DOT_FILE_DEPS tmux
