# Remove cache and state files
function _check_and_remove -a path
    if test -d "$path"
        rm -rf "$path"
    end
end

_check_and_remove ~/.local/share/nvim
_check_and_remove ~/.local/state/nvim
_check_and_remove ~/.cache/nvim

# Install the config from the repo
git clone https://github.com/TeddyHuang-00/AstroNvimConfig.git ~/.config/nvim

# Finish the install in nvim
set -gxa DOT_FILE_CAVEATS "Please finish the install in nvim by running <Space> + p + a"

# Export dependency
set -gxa DOT_FILE_DEPS nvim
