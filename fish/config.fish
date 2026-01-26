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
function note --description 'Opens in nvim note.md'
    echo "Pulling notes..."
    pushd /Users/kotsmile/notes
    git pull
    popd

    /opt/homebrew/bin/nvim /Users/kotsmile/notes/note.md

    echo "Pushing notes..."
    pushd /Users/kotsmile/notes
    git add note.md
    git commit -m "Update note.md $(date)"
    git push
    popd
end

nvm use 20 1>/dev/null

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

function __auto_activate_venv --on-variable PWD --description 'Auto activate/deactivate Python venv'
    if test -d venv/bin -a -f venv/bin/activate.fish
        if not set -q VIRTUAL_ENV; or test "$VIRTUAL_ENV" != (pwd)/venv
            source venv/bin/activate.fish
        end
    else
        if set -q VIRTUAL_ENV
            deactivate
        end
    end
end

__auto_activate_venv
