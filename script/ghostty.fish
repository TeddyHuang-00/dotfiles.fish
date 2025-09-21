set -l config_dir (path resolve ~/.config/ghostty)

# Fetch the custom shader
wget -O "$config_dir/cursor_blaze.glsl" "https://raw.githubusercontent.com/hackr-sh/ghostty-shaders/refs/heads/main/cursor_blaze.glsl"

# Check if the font is installed
set -l font_name "Maple Mono NF CN"
if not type -q fc-list
    set -gxa DOT_FILE_CAVEATS "Unable to determine installation of '$font_name'. Please make sure it is installed or install it for Ghostty to work properly."
else
    set -l font_installed (fc-list : family | sort | uniq | grep -i "$font_name")
    if test -z "$font_installed"
        set -gxa DOT_FILE_CAVEATS "Font '$font_name' is not installed. Please make sure it is installed or install it for Ghostty to work properly."
    end
end

# Export dependency
set -gxa DOT_FILE_DEPS ghostty
