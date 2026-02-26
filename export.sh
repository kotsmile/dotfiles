echo "init nvim"
mv ~/.config/nvim ~/.config/nvim.b | true
ln -s "$(pwd)/nvim" ~/.config/nvim

echo "init zellij"
mv ~/.config/zellij ~/.config/zellij.b | true
ln -s "$(pwd)/zellij" ~/.config/zellij

echo "init tmux"
mv ~/.config/tmux ~/.config/tmux.b | true
ln -s "$(pwd)/tmux" ~/.config/tmux

echo "init kitty"
mv ~/.config/kitty ~/.config/kitty.b | true
ln -s "$(pwd)/kitty" ~/.config/kitty

echo "init fish"
mv ~/.config/fish ~/.config/fish.b | true
ln -s "$(pwd)/fish" ~/.config/fish

echo "init tmux"
mv ~/.tmux ~/.tmux.b | true
ln -s "$(pwd)/tmux" ~/.tmux
