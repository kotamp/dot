export EDITOR="vim"
export VISUAL="vim"

source "$ZDOTDIR/aliases"

autoload -U colors && colors

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_CACHE_HOME/histfile"

bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ki/.zshrc'

# End of lines added by compinstall

setopt HIST_SAVE_NO_DUPS

autoload -Uz compinit; compinit
_comp_options+=(globdots)
# source /completion.zsh

fpath=("$ZDOTDIR" $fpath) # should i use absolute path?
autoload -Uz purification_setup.sh; purification_setup.sh

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

alias d="dirs -v"
for index ({1..9}) alias "$index"="cd +${index}"; unset index

bindkey -v
export KEYTIMEOUT=1
cursor_mode() {
	    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
            if [[ ${KEYMAP} == vicmd ]] ||
                [[ $1 = 'block' ]]; then
                echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
                [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
            fi
        }

    zle-line-init() {
            echo -ne $cursor_beam
        }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# extract archives
source "$ZDOTDIR/scripts/extract.zsh"

# more programs
fpath=("$ZDOTDIR/plugins/zsh-completions/src" $fpath)

# /a/b/c/d/e => bd b => /a/b
source "$ZDOTDIR/plugins/zsh-bd/bd.zsh"

# highlighting - must be at the end
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
