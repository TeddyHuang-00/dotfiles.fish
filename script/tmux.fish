# Install TPM
if type -q tpack
    tpack install
else
    set -gxa DOT_FILE_CAVEATS "tpack not found, please install it and run `tpack install`"
end

# Update the shell path
set -l fish_path (which fish)
set -l config_path (path resolve ~/.config/tmux/tmux.conf)
set -l config_content "$(cat $config_path)"
string replace -a __FISH_SHELL_PATH__ "$fish_path" $config_content >$config_path

# Export dependency
set -gxa DOT_FILE_DEPS tmux tpack
