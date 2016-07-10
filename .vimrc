" Plugins {{{
"
"" java用
"NeoBundleLazy 'artur-shaik/vim-javacomplete2', {
"            \ 'autolode' : {'filetype' : 'java'}
"            \ }
"let g:JavaComplete_MavenRepositoryDisable = 0
"let g:JavaComplete_UseFQN = 1
"autocmd FileType java setlocal runtimepath+=/usr/lib/jvm/java-8-oracle
"autocmd FileType java setlocal omnifunc=javacomplete#Complete
"
"
"" markdown用
"NeoBundleLazy 'plasticboy/vim-markdown', {
"            \ 'autolode' : {'filetype' : 'md'}
"            \ }
"NeoBundle 'kannokanno/previm'
"NeoBundle 'tyru/open-browser.vim'
"
"" haskel用
"NeoBundleLazy 'eagletmt/ghcmod-vim', {
"            \ 'autolode' : {'filetype' : 'hs'}
"            \ }
"NeoBundleLazy 'kana/vim-filetype-haskell', {
"            \ 'autolode' : {'filetype' : 'hs'}
"            \ }
"
"" その他
"NeoBundle 'Shougo/vimshell.vim'
"NeoBundle 'jiangmiao/auto-pairs'
"
"call neobundle#end()
"
"" {{{
"
"" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別のプラグイン/インデントを有効化する
"filetype plugin indent on
"
"" インストールのチェック
"NeoBundleCheck
"
"" }}}
"
" }}}
" Setting of the Plugins {{{
"

"" 辞書系 {{{
"" vim-refのバッファをqで閉じられるようにする
"autocmd FileType ref-* nnoremap <buffer> <silent> q :<C-u>close<CR>
"
""辞書定義
"let g:ref_source_webdict_sites = {
"\    'je': {
"\     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
"\    },
"\    'ej': {
"\     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
"\    },
"\}
"
""デフォルトサイト
"let g:ref_source_webdict_sites.default = 'ej'
"
""出力に対するフィルタ
""最初の数行を削除
"function! g:ref_source_webdict_sites.je.filter(output)
"   return join(split(a:output,"\n")[18 :], "\n")
"endfunction
"
"function! g:ref_source_webdict_sites.ej.filter(output)
"   return join(split(a:output, "\n")[18 :], "\n")
"endfunction
"" }}}
"
"

"
"
"
"
"
""}}}

if &compatible
   set nocompatible
endif

" reset augroup
augroup myAutoCmd
   autocmd!
augroup END

" dein settings {{{
" quote: http://qiita.com/delphinus35/items/00ff2c0ba972c6e41542

"プラグインが実際にインストールされているディレクトリ
let s:dein_dir = expand('~/.vim/dein')
"dein.vim本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
   if !isdirectory(s:dein_repo_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
   endif
   execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

"プラグインを収めたTOMLファイル
let s:toml       = '~/.vim/rc/dein.toml'
let s:lazy_toml  = '~/.vim/rc/dein_lazy.toml'

"設定開始
if dein#load_state(s:dein_dir)
   call dein#begin(s:dein_dir, [s:toml, s:lazy_toml])


   "TOMLを読み込み、キャッシュしておく
   call dein#load_toml(s:toml,      {'lazy': 0})
   call dein#load_toml(s:lazy_toml, {'lazy': 1})

   "設定終了
   call dein#end()
   call dein#save_state()
endif

if dein#check_install()
   call dein#install()
endif

filetype plugin indent on
" }}}

set runtimepath^=~/.vim/rc
runtime! plugins/*.vim


"---------------"
"### Display ###"
"---------------"

syntax on "syntaxを有効にする
set number "行番号を表示する
set tabstop=3 "インデントを3つ分に設定
set smartindent "オートインデント
set shiftwidth=3 "オートインデントの際の幅を3つ分に設定
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
" colorscheme hybrid "カラースキームをhybridにする
" highlight Normal ctermbg = none "背景を半透明にする


"--------------"
"### Search ###"
"--------------"

set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set hlsearch "検索文字をハイライト
set incsearch "インクリメンタルサーチをする
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ
set wildmenu "補完候補を表示する

"-------------------"
"### Key Mapping ###"
"-------------------"

" jj :insert-modeを抜ける
inoremap <silent> jj <ESC>
" j : display lines downward.
noremap j gj
" k : display lines upward.
noremap k gk
" <ESC><ESC> : Stop the highlighting for the 'hlsearch' option.
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
"" <Space>re : Open the dictionary of English to Japanese
"nnoremap <Space>re :Ref webdict ej<Space>
"" <Space>rj : Open the dictionary of Japanese to English
"nnoremap <Space>rj :Ref webdict je<Space>
" Toggle spell and nospell
nnoremap <space>s :<C-u>set spell!<CR>

" <Space>. : open my vimrc <- http://kannokanno.hatenablog.com/entry/20121217/1355694191
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>



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
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sw :<C-u>w<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
" These 's' mapping quoted from " http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca "


"-------------"
"### Other ###"
"-------------"

set mouse=a "The mouse can be enabled for all modes
set clipboard=unnamed,autoselect
set backspace=start,eol,indent "backspaceを通常のエディタの様にする

" markdown
au BufRead,BufNewFile *.md set filetype=markdown

" rust
au BufRead,BufNewFile *.rs set filetype=rust
