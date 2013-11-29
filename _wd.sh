#compdef wd

zstyle ":completion:*:descriptions" format "%B%d%b"
zstyle ':completion::complete:wd:*:commands' group-name commands
zstyle ':completion::complete:wd:*:warp_points' group-name warp_points

CONFIG=$HOME/.warprc

zmodload zsh/mapfile

local ret=1


_wd()
{
    # init variables
    local curcontext="$curcontext" state line
    typeset -A opt_args

    local -a warp_points
    warp_points=( "${(f)mapfile[$CONFIG]}" )

    local -a commands
    commands=(
        'add:Adds the current working directory to your warp points'
        'add!:Overwrites existing warp point'
        'rm:Removes the given warp point'
        'list:Outputs all stored warp points'
        'help:Show this extremely helpful text'
        '..:Go back to last directory'
    )

    _arguments -C \
        '1: :->first_arg' \
        '2: :->second_arg' && ret=0

    case $state in
        first_arg)
            _describe -t warp_points "Warp points" warp_points && ret=0
            _describe -t commands "Commands" commands && ret=0
            ;;
        second_arg)
            case $words[2] in
                add|add!|rm)
                    _describe -t warp-points 'Warp points' warp_points && ret=0
                    ;;
                *)
                    _message 'There are only two arguments when using the \`add\`, \`add!\` and \`rm\` commands.' && ret=0
                    ;;
            esac
            ;;
    esac
}

_wd "$@"
