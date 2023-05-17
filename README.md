個人的ターミナル見た目設定集．
おおむねこのような見た目になる．
![terminal](https://github.com/great-cactus/dotfiles/blob/main/terminal_view.png)

# WSL への導入

1. 必要なモジュールをインストールする．

```bash
sudo apt update
sudo apt upgrade -yV
sudo apt install git zsh vim tmux fzf
```

2. vimのプラグイン管理ツール，[vim-jetpack](https://github.com/tani/vim-jetpack)をインストールする．

```bash
curl -fLo ~/.vim/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs [https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim](https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim)
```

3. tmuxのプラグイン管理ツール，[tmux-plugins](https://github.com/tmux-plugins)をインストールする．

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

4. このレポジトリをクローンする．

# Vimのチュートリアル
vimはいちいちマウスに手を移さなくてもファイル編集が自在にできて便利なので，覚えておくにしくはないです．
Vimは主に3つのモードを持っています。
- Normal Mode: テキストの編集をせず、コマンドの入力やカーソルの移動に使います。Vimを起動したときのデフォルトのモードです。
- Insert Mode: テキストの編集に使います。Normal Modeからiキーを押すことで入ります。
- Command-Line Mode: Vimのコマンドを入力します。Normal Modeから:キーを押すことで入ります。
## 代表的な操作
以下に代表的なコマンドについて示します．
| コマンド | モード | 説明 |
| --- | --- | --- |
| `h` | Normal | 左へ移動する |
| `j` | Normal | 上へ移動する |
| `k` | Normal | 下へ移動する |
| `l` | Normal | 右へ移動する |
| `i` | Normal | カーソルの前で挿入モードに入る |
| `a` | Normal | カーソルの後で挿入モードに入る |
| `v` | Normal | ビジュアルモードに入る |
| `:w` | Normal | ファイルを保存する |
| `:q` | Normal | ファイルを閉じる |
| `:wq` | Normal | ファイルを保存して閉じる |
| `u` | Normal | 直前の操作を元に戻します。 |
| `Ctrl+r` | Normal | 直前の元に戻し操作を再度実行します。 |
| `dd` | Normal | 現在の行を削除します。|
| `yy` | Normal | 現在の行をコピーします。 |
| `p` | Normal | コピーした行を現在の行の下に貼り付けます。 |
| `/` | Normal | テキストを検索します。 |
| `n` | Normal | 検索結果を次に進めます。 |
| `N` | Normal | 検索結果を前に戻します。 |
| `:%s/foo/bar/g` | Normal | ファイル全体で"foo"を"bar"に置換する． |
| `:%s/foo/bar/gc` | Normal | ファイル全体で"foo"を"bar"に置換する．変換の際に確認する． |
| `:split` | Normal | 画面を水平に分割する |
| `:vsplit` | Normal | 画面を垂直に分割する |
| `Ctrl+w` その後 `h`, `j`, `k`, `l` | Normal | 分割した画面間を移動する |
| `ESC` | Insert/Command-Line | Normal Modeに戻る |
## 個人的に設定している動作
以下はリポジトリ内の.vimrcに固有の操作です．プラグイン導入を前提としているものもあります．
| 操作キー | モード | 機能 | 必要なプラグイン |
|---|---|---|---|
| `<Esc><Esc>` | Normal | ハイライト検索を無効化 | - |
| `{` | Insert | `{}`と入力し、カーソルを中括弧の間に移動 | - |
| `(` | Insert | `()`と入力し、カーソルを丸括弧の間に移動 | - |
| `[` | Insert | `[]`と入力し、カーソルを角括弧の間に移動 | - |
| `'` | Insert | `''`と入力し、カーソルをシングルクォーテーションの間に移動 | - |
| `"` | Insert | `""`と入力し、カーソルをダブルクォーテーションの間に移動 | - |
| `<Leader>s` (デフォルトでは`<Space>s`) | Normal | ドキュメント内で文字列の置換を開始 | - |
| `<leader>f` | Normal | FZFを使ってファイルを検索 | fzf, fzf.vim |
| `<leader>g` | Normal | FZFを使ってGitファイルを検索 | fzf, fzf.vim |
| `<leader>G` | Normal | FZFを使ってGitのログからファイルを検索 | fzf, fzf.vim |
| `<leader>b` | Normal | FZFを使って開いているバッファを検索 | fzf, fzf.vim |
| `<leader>h` | Normal | FZFを使って履歴を検索 | fzf, fzf.vim |
| `<leader>r` | Normal | FZFを使ってRgコマンドで検索 | fzf, fzf.vim |
| `<leader>y` | Normal | 現在のファイルのフルパスをクリップボードにコピー | - |
| `<F5>` | Normal | Pythonスクリプトを実行 | - |
| `;` (USキーボードの場合) | Normal | `:`と同等の操作 | - |
| `:` (USキーボードの場合) | Normal | `;`と同等の操作 | - |

