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
