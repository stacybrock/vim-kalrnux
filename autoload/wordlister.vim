let s:wordlists_dir = expand('<sfile>:p:h:h').'/wordlists/'

function! wordlister#update()
  let l:wordlists_files = glob(s:wordlists_dir.'*.words', v:true, v:true)
  let l:wordlist_full = []
  for filename in l:wordlists_files
    if index(g:wordlister_blacklist, fnamemodify(filename, ':t:r')) < 0
      call extend(l:wordlist_full, readfile(filename))
    endif
  endfor
  let l:wordlist_output_file = tempname()
  call writefile(l:wordlist_full, l:wordlist_output_file)
  let l:spell_dir = spellfile#WritableSpellDir().'/'
  call mkdir(l:spell_dir, 'p')
  execute 'mkspell! '.l:spell_dir.'wordlister'.' '.l:wordlist_output_file
endfunction
