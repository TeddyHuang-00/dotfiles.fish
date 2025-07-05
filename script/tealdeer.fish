if not type -q tldr
    set -gxa DOT_FILE_CAVEATS "Make sure to install tealdeer (not tldr) to use the configuration."
else if test (tldr --version | cut -d " " -f 1) != tealdeer
    set -gxa DOT_FILE_CAVEATS "tldr is installed, but it is not tealdeer. Please install tealdeer to use the configuration."
end

# Export dependency
set -gxa DOT_FILE_DEPS tldr
