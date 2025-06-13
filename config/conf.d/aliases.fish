# Aliases for fish shell
status is-interactive || exit

# Set up aliases
if type -q logo-ls
    alias l "logo-ls -T"
    alias ll "l -lo"
    alias la "ll -A"
    alias lr "ll -R"
end

if type -q btop
    alias top btop
end

if type -q icdiff
    alias diff icdiff
end

if type -q jaq
    alias jq jaq
end

if type -q xdg-open
    alias open xdg-open
end

if type -q rutd-cli
    alias td rutd-cli
end

if type -q go-task
    alias task go-task
end

if type -q bun
    alias svgo "bunx svgo"
end

if type -q uv
    alias scour "uvx scour"
    alias rsyncy "uvx rsyncy"
end

if test -f /Applications/Tailscale.app/Contents/MacOS/Tailscale
    alias tailscale "/Applications/Tailscale.app/Contents/MacOS/Tailscale"
end
