function version --description 'Prints version of dev kit'
    echo "$(python3 --version)"
    echo "$(go version)"
    echo "Node $(node -v)"
    echo "$(rustc --version)"
end
