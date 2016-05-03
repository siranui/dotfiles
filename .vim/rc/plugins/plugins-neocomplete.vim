let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#in_keyword_length = 3
if !exists('g:neocomplete#keyword_patterns')
   let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

highlight Pmenu ctermbg=248 guibg=#606060
highlight PmenuSel ctermbg=159 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6

augroup cpp-path
   autocmd!
   autocmd FileType cpp setlocal path=.,/usr/include/c++/
augroup END
