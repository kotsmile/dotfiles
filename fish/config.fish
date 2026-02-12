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

function ynit -d "Initializes yandex"
    echo "Yandex here! Setting up YA..."
    set --export GOROOT "$(ya tool go --print-toolchain-path)"
    set --export ARCADIA /Users/kotsmile/arcadia
    set --export NODE_EXTRA_CA_CERTS /etc/ssl/certs/YandexInternalCA.pem
    set --export PATH $GOROOT/bin $PATH
end

function __auto_zellij
    if set -q ZELLIJ
        return
    end

    zellij attach --create main
end

if string match -q '*yndx*' (hostname)
    ynit
end

__auto_activate_venv
# __auto_zellij

function tun_ya_prod -d "Tunnels to yandex production"
    ssh -L 6443:localhost:6443 $YANDEX_PROD -N
end

function ssh_ya_prod -d "SSH to yandex production"
    ssh $YANDEX_PROD
end
