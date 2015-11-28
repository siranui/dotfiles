"---------------"
"### Plugins ###"
"---------------"

" neobundle {{{
" vim起動時のみruntimepathにneobundle.vimを追加
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" neobundle.vimの初期化
" NeoBundleを更新するための設定
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

"}}}

" 読み込むプラグインを記載

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/vimproc',
" vimprocの設定 {{{
\{
\ 'build' : {
\     'windows' : 'tools\\updata-dll-mingw',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\  },
\}
" }}}
"NeoBundle 'justmao945/vim-clang'
NeoBundle 'thinca/vim-ref'
NeoBundle 'mfumi/ref-dicts-en'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'kana/vim-filetype-haskell'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neocomplete.vim'

call neobundle#end()

" {{{

" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別のプラグイン/インデントを有効化する
filetype plugin indent on

" インストールのチェック
NeoBundleCheck

" }}}


"------------------------------"
"### Setting of the Plugins ###"
"------------------------------"

"" 'vim-clang' {{{
"let g:clang_c_options = '-std=c11'
"let g:clang_cpp_options = '-std=c++1z -stdlib=libc++ --pedantic-errors'
""}}}


" 辞書系 {{{
" vim-refのバッファをqで閉じられるようにする
autocmd FileType ref-* nnoremap <buffer> <silent> q :<C-u>close<CR>

"辞書定義
let g:ref_source_webdict_sites = {
\    'je': {
\     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
\    },
\    'ej': {
\     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
\    },
\}

"デフォルトサイト
let g:ref_source_webdict_sites.default = 'ej'

"出力に対するフィルタ
"最初の数行を削除
function! g:ref_source_webdict_sites.je.filter(output)
   return join(split(a:output,"\n")[18 :], "\n")
endfunction

function! g:ref_source_webdict_sites.ej.filter(output)
   return join(split(a:output, "\n")[18 :], "\n")
endfunction
" }}}


" easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}


" markdown {{{
au BufRead,BufNewFile *.md set filetype=markdown
" }}}


" indentLine {{{
let g:indentLine_faster = 1
nmap <silent><leader>i :<C-u>IndentLinesToggle<CR>
" }}}


" lightline {{{
let g:lightline = {
        \ 'colorscheme': 'jellybeans',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],[ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightLineModified',
        \   'readonly': 'LightLineReadonly',
        \   'fugitive': 'LightLineFugitive',
        \   'filename': 'LightLineFilename',
        \   'fileformat': 'LightLineFileformat',
        \   'filetype': 'LightLineFiletype',
        \   'fileencoding': 'LightLineFileencoding',
        \   'mode': 'LightLineMode'
        \ }
        \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" }}}


" unite {{{

" 参考URL(URLの上でgxで開く)
" http://qiita.com/jnchito/items/5141b3b01bced9f7f48f

" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


" }}}


" neocomplete {{{

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

" }}}


"---------------"
"### Display ###"
"---------------"

syntax on "syntaxを有効にする
set number "行番号を表示する
set tabstop=4 "インデントを4つ分に設定
set smartindent "オートインデント
set shiftwidth=4 "オートインデントの際の幅を4つ分に設定
set expandtab "タブを押した時にスペースでインデント
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
set cursorline "横線の表示
set splitbelow "新しいウィンドウを下に開く
set splitright "新しいウィンドウを右に開く
set foldmethod=marker "「{{{」と「}}}」に囲われた部分を折り畳む
set t_Co=256 "256色で表示する
set laststatus=2 "ステータスラインを2行で表示
set scrolloff=4 "上下４行の視界を確保
set background=dark "Vim will try to use colors that look good on a dark background.
colorscheme hybrid "カラースキームをhybridにする
highlight Normal ctermbg = none "背景を半透明にする


"--------------"
"### Search ###"
"--------------"

set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set hlsearch "検索文字をハイライト
set incsearch "インクリメンタルサーチをする
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ

"-------------------"
"### Key Mapping ###"
"-------------------"

" jj :insert-modeを抜ける
inoremap <silent> jj <ESC>
" fc : Close folds in {range}.
nnoremap <silent> fc :foldclose<CR>
" j : display lines downward.
noremap j gj
" k : display lines upward.
noremap k gk
" <ESC><ESC> : Stop the highlighting for the 'hlsearch' option.
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
" <Space>re : Open the dictionary of English to Japanese
nnoremap <Space>re :Ref webdict ej<Space>
" <Space>rj : Open the dictionary of Japanese to English
nnoremap <Space>rj :Ref webdict je<Space>

"nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
" 's' mappinf quoted from " http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca "


"-------------"
"### Other ###"
"-------------"

set mouse=a "The mouse can be enabled for all modes
set clipboard=unnamed,autoselect
set backspace=start,eol,indent "backspaceを通常のエディタの様にする

