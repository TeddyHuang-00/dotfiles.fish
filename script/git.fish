# Check if key dependencies are installed
if not type -q delta
    set -gxa DOT_FILE_CAVEATS "delta is not installed, please install it to make sure the git diff works"
end

if not type -q diffnav
    set -gxa DOT_FILE_CAVEATS "diffnav is not installed, please install it to make sure the git diff works"
end

# Export dependency
set -gxa DOT_FILE_DEPS git delta diffnav
