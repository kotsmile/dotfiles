if status is-interactive
end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true


# pnpm
set -gx PNPM_HOME "/Users/kotsmile/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

bind -M insert \cf accept-autosuggestion

function ll --wraps=ls --description 'List contents of directory using long format'
    exa -lah $argv
end


# starship init fish | source

export PATH="$PATH:/Users/kotsmile/.foundry/bin"

# use default version of node
nvm use 16 1> /dev/null
nvm use 18 1> /dev/null

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
