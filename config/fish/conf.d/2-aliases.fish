# Aliases for fish shell
status is-interactive || exit

# Set up aliases
if type -q logo-ls
    alias l "logo-ls -T"
    alias ll "l -lo"
    alias la "ll -A"
    alias lr "ll -R"
end

if type -q zoxide
    alias c "z"
    alias ci "zi"
end

if type -q btop
    alias top btop
end

if type -q icdiff
    alias diff icdiff
end

if type -q screen
    alias screen "screen -s fish -T xterm-256color -U"
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
