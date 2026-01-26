function note --description 'Opens in nvim note.md'
    if not test -d /Users/kotsmile/notes
        echo "Cloning notes..."
        git clone https://github.com/kotsmile/notes.git /Users/kotsmile/notes
    end

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
