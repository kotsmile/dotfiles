if status is-interactive
end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true


# pnpm
set -gx PNPM_HOME /Users/kotsmile/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

bind -M insert \cf accept-autosuggestion

function ll --wraps=ls --description 'List contents of directory using long format'
    exa -lah $argv
end

function zellij --wraps=zellij --description 'Opens a main zellij session'
    zellij attach main
end

# function zellijm --description 'Opens a main zellij session'
#   zellij attach main 
# end


# starship init fish | source

# export PATH="$PATH:/Users/kotsmile/.foundry/bin"

# # use default version of node
# nvm use 16 1> /dev/null
nvm use 20 1>/dev/null

set -Ux ATAC_KEY_BINDINGS "/Users/kotsmile/.config/atac/key_bindings.toml"
set -Ux RAINFROG_CONFIG "/Users/kotsmile/.config"
