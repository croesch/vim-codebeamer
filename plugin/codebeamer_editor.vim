"    vim-codebeamer: Codebeamer syntax and editing support for vim.
"    Copyright (C) 2017  Christian Roesch
"
"    This program is free software: you can redistribute it and/or modify
"    it under the terms of the GNU General Public License as published by
"    the Free Software Foundation, either version 3 of the License, or
"    (at your option) any later version.
"
"    This program is distributed in the hope that it will be useful,
"    but WITHOUT ANY WARRANTY; without even the implied warranty of
"    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"    GNU General Public License for more details.
"
"    You should have received a copy of the GNU General Public License
"    along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
