# Test for Homebrew installation and source if found
if test -d /opt/homebrew/bin
    # Homebrew on Apple Silicon
    set -gx HOMEBREW_PREFIX /opt/homebrew
else if test -d /home/linuxbrew/.linuxbrew/bin
    # Homebrew on Linux
    set -gx HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
else if test -d ~/homebrew/bin
    # Homebrew custom installation
    set -gx HOMEBREW_PREFIX ~/homebrew
end

if test -n "$HOMEBREW_PREFIX"
    $HOMEBREW_PREFIX/bin/brew shellenv | source
end

# Homebrew
set -la paths /opt/homebrew/opt/rustup/bin
# Cargo
set -la paths ~/.cargo/bin
# Go
set -la paths ~/go/bin
# Orbstack
set -la paths ~/.orbstack/bin
# Haskell
set -la paths ~/.ghcup/bin
# Bun
set -la paths ~/.bun/bin
# Other bin directories
set -la paths ~/.local/bin

for p in (path normalize $paths | path filter -d)
    fish_add_path -m $p
end
