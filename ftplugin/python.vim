set list

augroup vim_kalrnux_py
  autocmd!

  " highlight overly long lines
  au BufEnter * highlight OverLength ctermbg=darkgrey guibg=#111111
  au BufEnter * match OverLength /\%>80v.\+/
augroup END
