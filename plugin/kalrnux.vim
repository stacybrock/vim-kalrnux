" kalrnux.vim
" 
" various tweaks to vim that require implementations that
" would otherwise clutter .vimrc


" improved paste mode
" excerpted from tpope's vim-unimpaired plugin
" https://github.com/tpope/vim-unimpaired
function! s:setup_paste() abort
    let s:paste = &paste
    let s:mouse = &mouse
    set paste
    set mouse=
endfunction

nnoremap <silent> <Plug>unimpairedPaste :call <SID>setup_paste()<CR>

nnoremap <silent> yp :call <SID>setup_paste()<CR>a
nnoremap <silent> yP :call <SID>setup_paste()<CR>i
nnoremap <silent> yo :call <SID>setup_paste()<CR>o
nnoremap <silent> yO :call <SID>setup_paste()<CR>O
nnoremap <silent> yA :call <SID>setup_paste()<CR>A
nnoremap <silent> yI :call <SID>setup_paste()<CR>I
nnoremap <silent> ygi :call <SID>setup_paste()<CR>gi
nnoremap <silent> ygI :call <SID>setup_paste()<CR>gI

augroup unimpaired_paste
    autocmd!
    autocmd InsertLeave *
                \ if exists('s:paste') |
                \ let &paste = s:paste |
                \ let &mouse = s:mouse |
                \ unlet s:paste |
                \ unlet s:mouse |
                \ endif
augroup END


" load custom word lists for vimspell
" inspired by vim-dirtytalk
" https://github.com/psliwka/vim-dirtytalk
let g:wordlister_blacklist = get(g:, 'wordlister_blacklist', [])

command! WordlisterUpdate call wordlister#update()


" renumber simple incremented markdown lists
python3 << endpython

import re
import vim

def ReincrementList():
  range = vim.current.range
  m = re.match('(\d+)\.', range[0])
  start_num = int(m.group(1))

  for i, line in enumerate(range):
      line_num = range.start + 1 + i
      new_num = start_num + i
      vim.command(f"{line_num}s/\d\+\./{new_num}\./")

  vim.command(":nohlsearch")
endpython

if has("python3")
    command! -range ReincrementList '<,'> python3 ReincrementList()
    vnoremap <silent> <leader>R :ReincrementList<CR>
endif
