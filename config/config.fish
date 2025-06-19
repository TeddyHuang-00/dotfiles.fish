# Platform specific configuration for Fish shell
switch (uname -o)
    case GNU/Linux
        # Linux-specific settings
        source (path normalize ~/.config/fish/linux/**/*.fish)
    case Darwin
        # macOS-specific settings
        source (path normalize ~/.config/fish/macos/**/*.fish)
    case '*'
        # Other platforms (if any)
end

# Commands to run in interactive sessions can go here
if status is-interactive
    # Completion engine
    if type -q carapace
        set -gxa CARAPACE_EXCLUDES brew
        carapace _carapace fish | source
    end

    # Prompt
    if type -q starship
        function starship_transient_prompt_func
            starship module character
        end
        function starship_transient_rprompt_func
            starship module time
        end
        starship init fish | source
        enable_transience
    end
end
