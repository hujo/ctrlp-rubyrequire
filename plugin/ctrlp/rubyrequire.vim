if get(g:, 'loaded_ctrlp_rubyrequire', 0)
  finish
endif
command! CtrlPRubyRequire call ctrlp#init(ctrlp#rubyrequire#id())
