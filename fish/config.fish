if status is-interactive
end

[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

set -gx PNPM_HOME /Users/kotsmile/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

bind -M insert \cf accept-autosuggestion

nvm use 25 1>/dev/null

set fish_cursor_default block
set fish_cursor_insert block

set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set --export EDITOR nvim
set TERM xterm-256color

if string match -q '*yndx*' (hostname)
    echo "Yandex here! Setting up YA..."
    set --export GOROOT "$(ya tool go --print-toolchain-path)"
    set --export ARCADIA /Users/kotsmile/arcadia
    set --export NODE_EXTRA_CA_CERTS /etc/ssl/certs/YandexInternalCA.pem
    set --export PATH $GOROOT/bin $PATH
end

__auto_activate_venv
