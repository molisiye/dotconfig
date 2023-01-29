# Created by newuser for 5.8
export LANGUAGE=en_US # :zh_CN

# proxy
proxy () {
  export http_proxy="http://192.168.116.1:7890"
  export https_proxy=$http_proxy
  export socks5_proxy="socks5://192.168.116.1.1:7890"
  echo "HTTP Proxy on"
}

# noproxy
noproxy () {
  unset http_proxy
  unset https_proxy
  echo "HTTP Proxy off"
}


#if [[ -z $TMUX && $- == *i* ]]; then
#    if [[ ! "$(</proc/$PPID/cmdline)" =~ "/usr/bin/(dolphin|emacs|kate)|visual-studio-code|code" ]]; then
#        exec tmux -f "$HOME/.config/tmux/tmux.conf"
#    fi
#else
#    if [[ "$(</proc/$PPID/cmdline)" =~ "konsole" ]]; then
#        unset TMUX TMUX_PANE
#    fi
#fi

# ===== zinit =====
#typeset -A ZINIT=(
#    BIN_DIR     ~/.zinit/bin
#    HOME_DIR    ~/.zinit
#    COMPINIT_OPTS -C
#)

typeset -F4 SECONDS=0

[[ ! -f ~/.zinit/bin/zinit.zsh ]] && {
    command mkdir -p ~/.zinit
    command git clone https://github.com/zdharma/zinit ~/.zinit/bin
}

source ~/.zinit/bin/zinit.zsh
#autoload -Uz _zinit
#((${+_comps})) && _comps[zinit]=_zinit

# ===== function =====
#PATH=$HOME/.config/zsh/commands:$HOME/.ecmacs.d/bin/doom:$PATH
#FPATH=$HOME/.config/zsh/functions:$HOME/.config/zsh/completions:$FPATH

#autoload -Uz $HOME/.config/zsh/functions/*(:t)
#autoload +X zman
autoload -Uz allopt zed zcalc zmv zargs

# ===== =====
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
#ZSH_AUTOSUGGEST_COMPLETION_IGNORE='( |man |pikaur -S )*'

GENCOMP_DIR=$HOME/.config/zsh/completions

forgit_add=gai
forgit_diff=gdi
forgit_log=glgi

# ===== load plugin =====
zinit wait="1" lucid light-mode for \
    hlissner/zsh-autopair \
    Aloxaf/gencomp \
    agkozak/zsh-z \
    wfxr/forgit

zinit light-mode for \
    blockf \
        zsh-users/zsh-completions \
    as="program" atclone="rm -f ^(rgg|agv)" \
        lilydjwg/search-and-view \
    atclone="dircolors -b LS_COLORS > c.zsh" atpull='%atclone' pick='c.zsh' \
        trapd00r/LS_COLORS \
    src="etc/git-extras-completion.zsh" \
        tj/git-extras

zinit wait="1" lucid for \
    OMZ::lib/clipboard.zsh \
    OMZ::lib/git.zsh \
    OMZ::plugins/systemd/systemd.plugin.zsh \
    OMZ::plugins/sudo/sudo.plugin.zsh
    #OMZ::plugins/git/git.zsh

zinit ice mv=":cht.sh -> cht.sh" atclone="chmod +x cht.sh" as="program"
zinit snippet https://cht.sh/:cht.sh

#zinit svn for \
 #   OMZ::plugins/extract \
  #  OMZ::plugins/pip

zinit as="completion" for \
    OMZ::plugins/docker/_docker \
    OMZ::plugins/rust/_rust \
    OMZ::plugins/fd/_fd

#source /etc/grc.zsh
#source ~/.travis/travis.sh
#source ~/Coding/shell/zvm/zvm.zsh

# ===== =====
#zpcompinint; zpcdreplay


#for i in $HOME/.config/zsh/plugins/*/*.plugin.zsh; do
#    source $i
#done

# ===== fzf-tab =====
#source ~/Coding/shell/fzf-tab/fzf-tab.zsh

#zstyle ':fzf-tab:complete:_zlua:*' query-string input

# ===== =====
# https://blog.lilydjwg.me/2015/7/26/a-simple-zsh-module.116403.html
#zmodload aloxaf/subreap
#subreap

zinit light-mode for \
    zdharma/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions

# ===== Theme =====
: ${THEME:=spaceship}

case $THEME in
    pure)
        PROMPT=$'\n%F{cyan}> %f'
        RPROMPT=""
        zstyle ':prompt:pure:prompt:succeess' color cyan
        zinit ice lucid wait="!0" pick="async.zsh" src="pure.zsh" atload="prompt_pure_precmd"
        zinit light Aloxaf/pure
        ;;
    p10k)
        souce $HOME/.config/zsh/p10k.zsh
        zinit ice depth=1
        zinit light romkatv/powerlevel10k
        ;;
    spaceship)
        zinit light denysdovhan/spaceship-prompt
        ;;
esac