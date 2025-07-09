# バグ調査報告書

## 不具合の概要
claude code用の入力boxがnormal modeで`<Enter>`を押していないのに、勝手に閉じる問題が発生している。
特に`skkeleton.vim`プラグインをトグルするため`<Ctrl>+j`を押下すると、この不具合が生じる。

## 調査結果

### 1. claude.luaの実装分析

#### 発見した問題点
- `open_input_window()` 関数（行150-200）で入力ウィンドウが作成される
- 行192でバッファローカルマッピングが設定される：
  ```lua
  vim.keymap.set('i', '<C-j>', function() M.send_input() end, opts)
  ```
- このマッピングによりinsert mode時に`<C-j>`が押下されると`send_input()`が呼び出される
- `send_input()`関数（行209-236）は入力ウィンドウを閉じる処理を含む（行225）

#### 潜在的な問題
- 入力ウィンドウが開いている状態で`<C-j>`を押下すると、意図せず`send_input()`が実行される
- この動作はskkeletonのトグル機能と競合する可能性がある

### 2. dein_lazy.tomlでのskkeleton.vim実装分析

#### 設定内容の確認
- 行245-249でskkeletonのキーマッピングが設定されている：
  ```vim
  inoremap <C-j>  <Plug>(skkeleton-toggle)
  cnoremap <C-j>  <Plug>(skkeleton-toggle)
  tnoremap <C-j>  <Plug>(skkeleton-toggle)
  nnoremap <C-j> i<Plug>(skkeleton-enable)
  ```

#### 発見した問題点
- `<C-j>`がskkeletonのトグル機能にマッピングされている
- claude.luaの入力ウィンドウでも同じ`<C-j>`キーが使用されている
- キーマッピングの競合が発生している可能性がある

### 3. vim-skk/skkeleton実装の調査

#### 技術的背景
- skkeletonは`'iminsert'`オプションを使用してlanguage-mappingを制御する
- `'iminsert'`が1に設定され、少なくとも1つの`:lmap`が定義されている場合、language mappingsがアクティブになる
- `<C-j>`とEnterキーはターミナルレベルで同じ文字（carriage return）として扱われる

#### 潜在的な問題
- `<C-j>`の動作を独立して無効化・再マッピングするのは困難
- Enterキーの機能に影響を与える可能性がある

## 根本原因分析

### 主な問題
1. **キーマッピングの競合**: claude.luaの入力ウィンドウとskkeletonの両方で`<C-j>`を使用
2. **バッファローカルマッピングの問題**: 入力ウィンドウがアクティブな状態で`<C-j>`を押すと、skkeletonのトグル前にclaude.luaの処理が実行される
3. **イベントハンドリングの順序問題**: キーマッピングの優先順位により、意図しない動作が発生

### 不具合の発生シーケンス
1. claude.luaの入力ウィンドウが開く
2. ユーザーが`<C-j>`を押下（skkeletonをトグルする意図）
3. バッファローカルマッピングにより`send_input()`が先に実行される
4. 入力ウィンドウが閉じられる（行225: `M.close_input_window()`）
5. skkeletonのトグル処理が実行される（が、既にウィンドウが閉じているため、ユーザーには予期しない動作に見える）

## 推奨される解決策

### 1. 短期的な解決策
- claude.luaの入力ウィンドウで`<C-j>`の代わりに別のキーを使用する
- 例：`<C-l>`や`<C-k>`など、skkeletonと競合しないキーを使用

### 2. 長期的な解決策
- 入力ウィンドウでskkeletonの状態を考慮したキーマッピングを実装
- skkeletonがアクティブな場合は、claude.luaの`<C-j>`マッピングを無効化する仕組みを実装

### 3. 実装の改善提案
```lua
-- 修正案: claude.luaの行192を変更
vim.keymap.set('i', '<C-l>', function() M.send_input() end, opts)  -- <C-j>から<C-l>に変更
```

## 結論
この不具合は、claude.luaとskkeletonの間での`<C-j>`キーマッピングの競合により発生している。バッファローカルマッピングの優先順位により、意図しない動作が発生している。キーマッピングの変更または、より高度なイベントハンドリングの実装が必要である。