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

" Vim syntax file
" Language:     Codebeamer
" Maintainer:   Christian Roesch
" Filenames:    *.cb

if exists("b:current_syntax")
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'cb'
endif

syn region cbH1 matchgroup=cbHeadingDelimiter start="!1"                  end="$" keepend oneline
syn region cbH2 matchgroup=cbHeadingDelimiter start="\%\(!!!\|!2\)"       end="$" keepend oneline
syn region cbH3 matchgroup=cbHeadingDelimiter start="!\%(!\(!\)\@!\|3\)"  end="$" keepend oneline
syn region cbH4 matchgroup=cbHeadingDelimiter start="!\([1-3!]\)\@!4\?"   end="$" keepend oneline
syn region cbH5 matchgroup=cbHeadingDelimiter start="!5"                  end="$" keepend oneline

syn region cbComment start="//" end="$"

syn match cbListMarker "[*#]\+\%(\s\+\S\)\@="

syn match cbRule "----[-]*$"

syn region cbUrl start="[\~\[]\@<!\[\[\@!" end="\~\@<!\]" keepend contains=cbUrlNumber,cbUrlLink,cbUrlAlias,cbUrlDelimiter
syn match cbUrlDelimiter "[:|]" contained
syn match cbUrlLink "[\[|]\zs[^\]]\+\ze\]" contained
syn match cbUrlAlias "\[\zs[^\]]\+\ze|" contained
syn match cbUrlAlias "\[\zs[^\]]\+\ze:\d\+\]" contained
syn match cbUrlNumber "\[\zs#\?\d\+\ze\]" contained

syn region cbSpecial start="%%\w" end="%%\w\@!"
syn region cbError start="%%error" end="%%" keepend
syn region cbWarn start="%%warning" end="%%" keepend
syn region cbSuper start="\^\^" end="\^\^" keepend
syn region cbSub start=",," end=",," keepend
syn region cbItalic start="''" end="''" keepend
syn region cbBold start="__" end="__" keepend
syn region cbCode start="{{" end="}}" keepend
syn region cbCode start="{{{" end="}}}" keepend

syn match cbLineBreak "\\\\\\\?"

syn match cbDefinition "^;.*:.*$"
syn match cbBlockquote ">\+\%(\s\|$\)"

syn region cbTableHeader matchgroup=cbTableDelimiter start="^||" end="$" contains=ALL
syn region cbTableRow matchgroup=cbTableDelimiter start="^||\@!" end="$" contains=ALL
syn match cbTableDelimiter "|" contained

hi def link cbH1                    Title
hi def link cbH2                    Title
hi def link cbH3                    Title
hi def link cbH4                    Title
hi def link cbH5                    Title
hi def link cbHeadingDelimiter      Delimiter
hi def link cbListMarker            Statement
hi def link cbComment               Comment
hi def link cbRule                  PreProc

hi def link cbUrl                   Float
hi def link cbUrlLink               Identifier
hi def link cbUrlAlias              Label
hi def link cbUrlDelimiter          Delimiter
hi def link cbUrlNumber             Number

hi def link cbSpecial               Special
hi def link cbError                 ErrorMsg
hi def link cbWarn                  WarningMsg
hi def link cbSuper                 BoldItalic
hi def link cbSub                   BoldItalic
hi def link cbBold                  Bold
hi def link cbBoldItalic            BoldItalic
hi def link cbItalic                Italic
hi def link cbCode                  String

hi def link cbLineBreak             Delimiter

hi def link cbDefinition            MoreMsg
hi def link cbBlockquote            Question

hi def link cbTableHeader           Title
hi def link cbTableDelimiter        Delimiter

let b:current_syntax = "cb"
if main_syntax ==# 'cb'
  unlet main_syntax
endif
