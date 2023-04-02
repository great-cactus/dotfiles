# dotfiles

個人的ターミナル見た目設定集

## WSL への導入

1. 必要なモジュールをインストールする．

```bash
sudo apt update
sudo apt upgrade -yV
sudo apt install git zsh vim tmux fzf
```

2. vimのプラグイン管理ツール，[vim-jetpack]([https://github.com/tani/vim-jetpack](https://github.com/tani/vim-jetpack))をインストールする．

```bash
curl -fLo ~/.vim/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs [https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim](https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim)
```

3. tmuxのプラグイン管理ツール，[tmux-plugins]([https://github.com/tmux-plugins](https://github.com/tmux-plugins))をインストールする．

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

4. このレポジトリをクローンする．
