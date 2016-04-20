let g:ctrlp_rubyrequire_appendfunc = get(g:, 'g:ctrlp_rubyrequire_appendfunc', 'ctrlp#rubyrequire#append')
let g:ctrlp_rubyrequire_mode = get(g:, 'ctrlp_rubyrequire_mode', 'h')

cal add(g:ctrlp_ext_vars, {
\ 'init': 'ctrlp#rubyrequire#init()',
\ 'accept': 'ctrlp#rubyrequire#accept',
\ 'lname': 'ruby require',
\ 'sname': 'rubyrequire',
\ 'type': 'tabs',
\ 'nolim': 1
\ })

let s:rubyfile = expand('<sfile>:p:r') . '.rb'
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! ctrlp#rubyrequire#init()
  call s:syntax()
  return map(ctrlp#rubyrequire#getpaths(), 'v:val[0] . "\t" . v:val[1]')
endfunction

function! ctrlp#rubyrequire#accept(mode, str)
  let [name, path] = split(a:str, "\t")
  if a:mode ==# g:ctrlp_rubyrequire_mode
    call ctrlp#exit()
    call call(g:ctrlp_rubyrequire_appendfunc, [name, path])
  else
    call ctrlp#acceptfile(a:mode, path)
  endif
endfunction

function! ctrlp#rubyrequire#id()
  return s:id
endfunction

function! ctrlp#rubyrequire#append(name, path)
  call append(0, printf("require '%s'", a:name))
endfunction

function! ctrlp#rubyrequire#getpaths()
  if s:use_rubyfile()
    rubyfile `=s:rubyfile`
  else
    return eval(system(printf('ruby %s', s:rubyfile)))
  endif
endfunction

function! s:use_rubyfile()
  if !exists('s:use_rubyfile')
    call s:check_ruby_version()
  endif
  if get(g:, 'ctrlp_rubyrequire_no_rubyfile', 0)
    return 0
  else
    return s:use_rubyfile
  endif
endfunction

function! s:check_ruby_version()
  if has('ruby')
    ruby VIM::command('let s:use_rubyfile = %d' % [`ruby -v`[/\d+\.\d+\.\d+/, 0] == RUBY_VERSION ? 1 : 0])
  else
    let s:use_rubyfile = 0
  endif
endfunction

function! s:syntax()
  if !ctrlp#nosy()
    call ctrlp#hicheck('CtrlPRubyrequireExtra', 'Comment')
    syntax match CtrlPRubyRequireExtra '\zs\t.*\ze$'
  endif
endfunction
