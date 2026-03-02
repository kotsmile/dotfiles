function __yandex_init --description "Yandex init"
    curl a.yandex-team.ru --fail --max-time .5 2>/dev/null 1>/dev/null
    if test $status -eq 0
        set -gx YANDEX true
    end
    if test -n "$YANDEX"
        yandex
    end
end
