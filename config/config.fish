# Commands to run in interactive sessions can go here
if status is-interactive
    # Completion engine
    carapace _carapace | source

    # Prompt
    function starship_transient_prompt_func
        starship module character
    end
    function starship_transient_rprompt_func
        starship module time
    end
    starship init fish | source
    enable_transience
end
