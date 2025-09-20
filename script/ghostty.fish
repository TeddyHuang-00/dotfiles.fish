set -l config_dir (path resolve ~/.config/ghostty)

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
