# Install TPM
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Finish the install in tmux
set -gxa DOT_FILE_CAVEATS "Please finish the install in tmux by running <Ctrl-a> + I"

# Export dependency
set -gxa DOT_FILE_DEPS tmux
