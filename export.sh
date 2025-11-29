echo "init nvim"
mv ~/.config/nvim ~/.config/nvim.b | true
ln -s "$(pwd)/nvim" ~/.config/nvim

echo "init zellij"
mv ~/.config/zellij ~/.config/zellij.b | true
ln -s "$(pwd)/zellij" ~/.config/zellij

echo "init kitty"
mv ~/.config/kitty ~/.config/kitty.b | true
ln -s "$(pwd)/kitty" ~/.config/kitty

echo "init zsh"
mv ~/.zshrc ~/.zshrc.b | true
ln -s "$(pwd)/.zshrc" ~/.zshrc
mv ~/.zfunc ~/.zfunc.b | true
ln -s "$(pwd)/.zfunc" ~/.zfunc
mv ~/.oh-my-zsh ~/.oh-my-zsh.b | true
ln -s "$(pwd)/.oh-my-zsh" ~/.oh-my-zsh

sudo chsh -s /bin/zsh
