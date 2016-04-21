if get(g:, 'loaded_ctrlp_rubyrequire', 0)
  finish
endif
let g:loaded_ctrlp_rubyrequire = 1

if !exists(':CtrlP')
  finish
endif

command! CtrlPRubyRequire call ctrlp#init(ctrlp#rubyrequire#id())
