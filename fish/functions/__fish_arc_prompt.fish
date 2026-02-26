function __fish_arc_prompt
    set -l info (arc info --json 2>/dev/null)
    or return
    set -l branch (echo $info | string match -r '"branch":"([^"]*)"' | tail -1)
    test -n "$branch"; or return

    # Ahead/behind
    set -l remote (echo $info | string match -r '"remote":"([^"]*)"' | tail -1)
    set -l repository (echo $info | string match -r '"repository":"([^"]*)"' | tail -1)
    set -l ahead 0
    set -l behind 0
    if test -n "$remote"
        # time set ahead (arc log --oneline "$repository/$remote..HEAD" 2>/dev/null | count)
        # time set behind (arc log --oneline "HEAD..$repository/$remote" 2>/dev/null | count)
    end

    set -l staged 0
    set -l dirty 0
    set -l untracked 0
    set -l conflicted 0

    for line in (arc status --short 2>/dev/null)
        set -l x (string sub -l 1 -- "$line")
        set -l y (string sub -s 2 -l 1 -- "$line")
        if test "$x" = U; or test "$y" = U
            set conflicted (math $conflicted + 1)
        else
            if test "$x" = "?"
                set untracked (math $untracked + 1)
            else
                if test "$x" != " "; and test "$x" != "?"
                    set staged (math $staged + 1)
                end
                if test "$y" != " "
                    set dirty (math $dirty + 1)
                end
            end
        end
    end

    # Build prompt
    echo -n " ("
    set_color magenta --bold
    echo -n "$branch"
    set_color normal

    set -l indicators
    if test $staged -gt 0
        set -a indicators (set_color yellow)"●$staged"(set_color normal)
    end
    if test $dirty -gt 0
        set -a indicators (set_color blue)"✚$dirty"(set_color normal)
    end
    if test $untracked -gt 0
        set -a indicators (set_color normal)"…$untracked"
    end
    if test $conflicted -gt 0
        set -a indicators (set_color red)"✖$conflicted"(set_color normal)
    end
    if test $ahead -gt 0
        set -a indicators (set_color cyan)"↑$ahead"(set_color normal)
    end
    if test $behind -gt 0
        set -a indicators (set_color cyan)"↓$behind"(set_color normal)
    end

    if test (count $indicators) -gt 0
        echo -n "|"
        echo -n (string join "" $indicators)
    else
        set_color green --bold
        echo -n "|✔"
        set_color normal
    end

    echo -n ")"
end
