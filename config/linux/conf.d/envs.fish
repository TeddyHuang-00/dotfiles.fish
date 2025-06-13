# Hyprland - nvidia compatibility settings
if type -q hyprland; and test -n "$(lspci | grep -i nvidia)"
    set -gx WLR_RENDERER_ALLOW_SOFTWARE 1
end
