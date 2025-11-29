fpath+=~/.zfunc

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git vi-mode zoxide)

source $ZSH/oh-my-zsh.sh

# echo -n "setting envs..."
export EDITOR="$(which nvim)"
export ARCADIA='/Users/kotsmile/arcadia'
# echo "done"

# User configuration
alias zshconfig="nvim ~/.zshrc"
alias ll='exa -lah'
alias arcm='arc mount $ARCADIA'


# echo -n "setting ya..."
GOROOT="$(ya tool go --print-toolchain-path)"
# echo "done"

# echo -n "setting path..."
PATH=$GOROOT/bin:$PATH
# echo "done"



export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion



zellij_update_tabname() {
    if [[ -n "$ZELLIJ" ]]; then
        local current_dir="$PWD"

        if [[ "$current_dir" == "$HOME" ]]; then
            current_dir="~"
        else
            current_dir="${PWD##*/}"
        fi

        nohup zellij action rename-tab "${current_dir}/" >/dev/null 2>&1
    fi
}

# Auto update tab name when directory changes
autoload -U add-zsh-hook

__auto_zellij_update_tabname() {
    zellij_update_tabname
}

add-zsh-hook chpwd __auto_zellij_update_tabname
