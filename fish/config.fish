if status is-interactive
end

[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

set -gx PNPM_HOME /Users/kotsmile/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

bind -M insert \cf accept-autosuggestion
function ll --wraps=ls --description 'List contents of directory using long format'
    exa -lah $argv
end
function zell --wraps=zellij --description 'Opens a main zellij session'
    /Users/kotsmile/.cargo/bin/zellij attach main || /Users/kotsmile/.cargo/bin/zellij -s main
end

nvm use 20 1>/dev/null

set fish_cursor_default block
set fish_cursor_insert block

set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

echo "Setting up YA"
set --export GOROOT "$(ya tool go --print-toolchain-path)"
set --export PATH $GOROOT/bin $PATH
set --export EDITOR nvim
set --export ARCADIA /Users/kotsmile/arcadia
set --export NODE_EXTRA_CA_CERTS /etc/ssl/certs/YandexInternalCA.pem
