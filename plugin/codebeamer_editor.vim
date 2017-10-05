let s:initialized_python = 0
let s:script_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! s:InitializeClient()
    if has('python3')
        let s:pcommand = 'python3'
        let s:pfile = 'py3file'
    else
        echo 'Error: this plugin requires vim compiled with python support.'
    finish
  endif

  if !s:initialized_python
    let s:initialized_python = 1
        execute s:pfile . ' ' . s:script_path . '/codebeamer_editor.py'
  endif
endfunction

function! s:CBRead(article_name)
  call <SID>InitializeClient()
    execute s:pcommand . " cb_read(vim.eval('a:article_name'))"
endfunction

function! s:CBWrite(...)
  call <SID>InitializeClient()
    execute s:pcommand . " cb_write(vim.eval('a:000'))"
endfunction

command! -nargs=1 CBRead call <SID>CBRead(<f-args>)
command! -nargs=? CBWrite call <SID>CBWrite(<f-args>)
