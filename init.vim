" Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}
" Plug 'osyo-manga/shabadou.vim'
"

if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{

" install "dein.vim"
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

let &runtimepath = s:dein_repo_dir .",". &runtimepath
" read plugin & create cache
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" auto install
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

"---------------"
"### Display ###"
"---------------"
"{{{
syntax on "syntaxを有効にする
set number "行番号を表示する
set tabstop=4 "インデントを4つ分に設定
set smartindent "オートインデント
set shiftwidth=4 "オートインデントの際の幅を4つ分に設定
set expandtab "タブを押した時にスペースでインデント
set notitle "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
" set cursorline "横線の表示
set splitbelow "新しいウィンドウを下に開く
set splitright "新しいウィンドウを右に開く
set foldmethod=marker "「{{{」と「}}}」に囲われた部分を折り畳む
augroup foldmethod_exchange_syntax
  autocmd!
  autocmd FileType c,cpp,go,java,js,rs,scala :set foldmethod=syntax
  autocmd FileType c,cpp,go,java,js,rs,scala :set foldlevel=10
  autocmd FileType c,cpp,go,java,js,rs,scala :set foldnestmax=10
augroup END
" set t_Co=256 "256色で表示する
set laststatus=2 "ステータスラインを2行で表示
set scrolloff=4 "上下４行の視界を確保



" 補完候補の色を変更
highlight Pmenu ctermbg=248 guibg=#606060
highlight PmenuSel ctermbg=159 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6

"}}}


"--------------"
"### Search ###"
"--------------"
"{{{
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set hlsearch "検索文字をハイライト
set incsearch "イクメンタルサーチをする
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ
set wildmenu "補完候補を表示する
"}}}


"-------------------"
"### Key Mapping ###"
"-------------------"
"{{{
" jj :insert-modeを抜ける
inoremap <silent> jj <ESC>
" j : display lines downward.
noremap j gj
" k : display lines upward.
noremap k gk
" <ESC><ESC> : Stop the highlighting for the 'hlsearch' option.
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
" Toggle spell and nospell
nnoremap <Leader>s :<C-u>set spell!<CR>

" <Leader>. : open my vimrc <- http://kannokanno.hatenablog.com/entry/20121217/1355694191
nnoremap <Leader>. :<C-u>tabedit $MYVIMRC<CR>



" http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
" <TAB> : jump to pair
nnoremap <TAB> %
vnoremap <TAB> %
" Bring to the center after the search.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz


" http://qiita.com/itmammoth/items/312246b4b7688875d023
" 行を移動
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp
" 複数行を移動
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

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
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sw :<C-u>w<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
" These 's' mapping quoted from " http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca "
"}}}


"----------------"
"### FileType ###"
"----------------"
"{{{
" markdown
au BufRead,BufNewFile *.md set filetype=markdown

" tex
" let g:tex_conceal="adgmb"
autocmd BufNewFile *.tex 0r $HOME/.vim/template/tex.txt

" " rust
" au BufRead,BufNewFile *.rs set filetype=rust hidden
" let g:racer_cmd = '/home/yuya/.multirust/toolchains/stable/cargo/bin/racer'
" let $RUST_SRC_PATH="/usr/local/src/rustc-beta/src"
" let g:rustfmt_autosave = 1
" let g:rustfmt_command = '$HOME/.cargo/bin/rustfmt'

" " golang
" filetype off
" filetype plugin indent off
" set runtimepath+=$GOROOT/misc/vim
" filetype plugin indent on
" syntax on
" autocmd FileType go autocmd BufWritePre <buffer> Fmt
" exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
" set completeopt=menu,preview
"}}}


"-------------"
"### Other ###"
"-------------"
"{{{
set mouse=a "The mouse can be enabled for all modes
" set clipboard=unnamed,autoselect
set backspace=start,eol,indent "backspaceを通常のエディタの様にする
set breakindent
set encoding=utf-8
augroup quickFixCmd
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END
"}}}

