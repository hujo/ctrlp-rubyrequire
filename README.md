### ctrlp-rubyrequire

#### 使い方
```
:CtrlPRubyRequire
```

#### オプション
```vim
" 非活性にします。
let g:loaded_ctrlp_rubyrequire = 1

" g:ctrlp_rubyrequire_modeで設定されたモードで選択された時に実行する関数名を設定します。
" デフォルトはctrlp#rubyrequire#appendです。
let g:ctrlp_rubyrequire_appendfunc = 'RubyRequireAppendFunc'

" g:ctrlp_rubyrequire_appendfuncで定義された関数を呼び出すモードを指定します。
" デフォルトは 'h' です。
let g:ctrlp_rubyrequire_mode = 'v'
```
