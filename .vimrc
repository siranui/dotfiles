" vim-plugが無ければ持ってくる {{{
if has('vim_starting')
   set rtp+=~/.vim/plugged/vim-plug
   if !isdirectory(expand('~/.vim/plugged/vim-plug'))
      echo 'install vim-plug...'
      call system('mkdir -p ~/.vim/plugged/vim-plug')
      call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
   end
endif
"}}}


call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-plug',
     \ {'dir': '~/.vim/plugged/vim-plug/autoload'}

Plug 'Shougo/vimproc.vim', {'do': 'make'}

Plug 'Shougo/denite.nvim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neomru.vim'

Plug 'scrooloose/nerdtree'

Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" if has('nvim')
"    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"    Plug 'Shougo/deoplete.nvim'
"    Plug 'roxma/nvim-yarp'
"    Plug 'roxma/vim-hug-neovim-rpc'
" endif


Plug 'cohama/lexima.vim',{'on': []}

Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}
Plug 'osyo-manga/shabadou.vim'

" colorschemes
Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'

Plug 'itchyny/lightline.vim'

Plug 'haya14busa/incsearch.vim'

Plug 'junegunn/vim-easy-align'

Plug 'Yggdroot/indentLine'

Plug 'bronson/vim-trailing-whitespace'

Plug 'Shougo/context_filetype.vim'
Plug 'osyo-manga/vim-precious'

Plug 'tyru/caw.vim'

Plug 'vim-jp/vimdoc-ja'

Plug 'tpope/vim-fugitive'

Plug 'Chiel92/vim-autoformat'

" for some languages
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
let g:vim_markdown_folding_disabled=1
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'
" Plug 'racer-rust/vim-racer', {'for': 'rust'}
" Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-clang-format', {'for': ['c', 'cpp']}
Plug 'justmao945/vim-clang', {'for': 'c'}
Plug 'vim-jp/cpp-vim', {'for': 'cpp'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'derekwyatt/vim-scala'
au BufNewFile,BufRead *.scala setf scala
Plug 'cespare/vim-toml', {'for': 'toml'}

" Plug 'mattn/benchvimrc-vim'

call plug#end()


"---------------"
"### Display ###"
"---------------"
"{{{
syntax on "syntaxを有効にする
set number "行番号を表示する
set tabstop=3 "インデントを3つ分に設定
set smartindent "オートインデント
set shiftwidth=3 "オートインデントの際の幅を3つ分に設定
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
set t_Co=256 "256色で表示する
set laststatus=2 "ステータスラインを2行で表示
set scrolloff=4 "上下４行の視界を確保
set background=dark "Vim will try to use colors that look good on a dark background.

" if file_readable(expand("~/.vim/plugged/vim-hybrid/colors/hybrid.vim"))
"    colorscheme hybrid "カラースキームをhybridにする
" endif
colorscheme default

" highlight Normal ctermbg = none "背景を半透明にする

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
set clipboard=unnamed,autoselect
set backspace=start,eol,indent "backspaceを通常のエディタの様にする
set breakindent
set encoding=utf-8
augroup quickFixCmd
   autocmd!
   autocmd QuickFixCmdPost *grep* cwindow
augroup END
"}}}


"--------------"
"### Pulgin ###"
"--------------"
" Setting for Pulgins {{{

" " unite {{{
" " 入力モードで開始する
" let g:unite_enable_start_insert=1
" " ヒストリー/ヤンク機能を有効化
" let g:unite_source_history_yank_enable=1
" " 画面分割時に下か右に開く
" let g:unite_split_rule='botright'
"
" " prefix keyの設定
" nmap <Leader>u [unite]
"
"
" "バッファを表示
" nnoremap <silent> [unite]bf :<C-u>Unite<Space>buffer<CR>
" "ブックマークの表示
" nnoremap <silent> [unite]bm :<C-u>Unite<Space>bookmark<CR>
" "カレントディレクトリを表示
" nnoremap <silent> [unite]c :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" "最近開いたディレクトリを表示
" nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
" "バッファと最近開いたファイル一覧を表示
" nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
" "ヒストリ/ヤンクを表示
" nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
" "マッピングを表示
" nnoremap <silent> [unite]m :<C-u>Unite<Space>mapping<CR>
" "outline
" nnoremap <silent> [unite]o :<C-u>Unite<Space>-vertical -winwidth=25 -no-quit outline<CR>
" "レジストリを表示
" nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
" "タブを表示
" nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
" "file_rec:!
" nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>
"
" " ESCキーを2回押すと終了する
" au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
" au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" "}}}

" denite {{{

" grep関連
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opts', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '--nocolor', '--nogroup', '-g', ''])

" mapping
call denite#custom#map(
         \ 'insert',
         \ '<C-n>',
         \ '<denite:move_to_next_line>',
         \ 'noremap'
         \)
call denite#custom#map(
         \ 'insert',
         \ '<C-p>',
         \ '<denite:move_to_previous_line>',
         \ 'noremap'
         \)

nmap <silent> <Leader>ub :<C-u>Denite buffer<CR>
nmap <silent> <Leader>ul :<C-u>Denite line<CR>
nmap <silent> <Leader>ug :<C-u>Denite line<CR>

"}}}

" neocomplete {{{

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#in_keyword_length = 3
if !exists('g:neocomplete#keyword_patterns')
   let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
if !exists('g:neocomplete#force_omni_input_patterns')
   let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

highlight Pmenu ctermbg=248 guibg=#606060
highlight PmenuSel ctermbg=159 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6

augroup cpp-path
   autocmd!
   autocmd FileType cpp setlocal path=.,/usr/include/
augroup END

"}}}

" neosnippet {{{
"Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=c
endif
"}}}

" 初めて挿入モードに入った時にロードする
augroup plug_on_insert
   autocmd!
   autocmd InsertEnter * call plug#load('neocomplete.vim', 'neosnippet', 'neosnippet-snippets', 'lexima.vim')
            \| autocmd! plug_on_insert
augroup END

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
"}}}

" easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"}}}

" indentLine {{{
let g:indentLine_faster = 1
let g:indentLine_setConceal = 0
nmap <silent><leader>i :<C-u>IndentLinesToggle<CR>
"}}}

" vimfiler {{{
" Quote : http://www.karakaram.com/vimfiler

" "vimデフォルトのエクスプローラをvimfilerで置き換える
" let g:vimfiler_as_default_explorer = 1
" "セーフモードを無効にした状態で起動する
" let g:vimfiler_safe_mode_by_default = 0
" "現在開いているバッファのディレクトリを開く
" nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
" "現在開いているバッファをIDE風に開く
" nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=25 -no-quit<CR>
"
" "デフォルトのキーマッピングを変更
" augroup vimrc
"    autocmd FileType vimfiler call s:vimfiler_my_settings()
" augroup END
" function! s:vimfiler_my_settings()
"    nmap <buffer> q <Plug>(vimfiler_exit)
"    nmap <buffer> Q <Plug>(vimfiler_hide)
" endfunction
" "}}}

" NERDTree {{{
nnoremap <silent> <Leader>fi :<C-u>NERDTree<CR>
" }}}

" vim-clang {{{
" disable auto completion for vim-clang
let g:clang_auto = 0
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

if executable('clang-3.8')
   let g:clang_exec = 'clang-3.8'
elseif executable('clang-3.7')
   let g:clang_exec = 'clang-3.7'
elseif executable('clang-3.6')
   let g:clang_exec = 'clang-3.6'
elseif executable('clang-3.5')
   let g:clang_exec = 'clang-3.5'
elseif executable('clang-3.4')
   let g:clang_exec = 'clang-3.4'
else
   let g:clang_exec = 'clang'
endif

if executable('clang-format-3.8')
   let g:clang_format_exec = 'clang-format-3.8'
elseif executable('clang-format-3.7')
   let g:clang_format_exec = 'clang-format-3.7'
elseif executable('clang-format-3.6')
   let g:clang_format_exec = 'clang-format-3.6'
elseif executable('clang-format-3.5')
   let g:clang_format_exec = 'clang-format-3.5'
elseif executable('clang-format-3.4')
   let g:clang_format_exec = 'clang-format-3.4'
else
   let g:clang_exec = 'clang-format'
endif

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++ --pedantic-errors'
"}}}

" vim-trailing-whitespace{{{
let g:extra_whitespace_ignored_filetypes = ["unite", "md", "vimfiler"]
"}}}

" vim-markdown {{{
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_style_pythonic = 1
"}}}

" previm {{{
let g:previm_open_cmd = ''
augroup PrevimSettings
   autocmd!
   autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
"}}}

" quickrun {{{

nnoremap <Leader>r :<C-u>QuickRun<CR>
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
         \ "runner":                          "vimproc",
         \ "runner/vimproc/updatetime":       40,
         \ "outputter":                       "error",
         \ "outputter/error/success":         "buffer",
         \ "outputter/error/error":           "quickfix",
         \ "outputter/buffer/split":          ":rightbelow 8sp",
         \ "outputter/buffer/close_on_empty": 1,
         \ }
let g:quickrun_config.markdown = {
         \ 'type': 'markdown/pandoc',
         \ 'cmdopt': '-s',
         \ 'outputter': 'browser'
         \ }
let g:quickrun_config.cpp = {
   \  'command': 'g++',
   \  'cmdopt': '-std=c++11'
   \ }

"}}}

" vim-clang-format {{{

map <silent><Leader>x <Plug>(operator-clang-format)

let g:clang_format#command = 'clang-format-3.8'

" アクセス指定子は1インデント分下げる
" 短い if 文は1行にまとめる
" テンプレートの宣言(template<class ...>)後は必ず改行する
" C++11 の機能を使う
" {} の改行は Stroustrup スタイル（関数宣言時の { のみ括弧前で改行を入れる）
let g:clang_format#style_options = {
         \ "AccessModifierOffset" : -4,
         \ "AllowShortIfStatementsOnASingleLine" : "true",
         \ "AlwaysBreakTemplateDeclarations" : "true",
         \ "Standard" : "C++11",
         \ "BreakBeforeBraces" : "Stroustrup",
         \ }
"}}}

" incsearch.vim {{{
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
"}}}

" vim-autoformat{{{
"" with scalafmt
let g:autoformat_verbosemode=1 " for output error

let g:formatdef_scalafmt = "'scalafmt  --stdin'"
" let g:formatdef_scalafmt = "'scalafmt --config /home/yuya/.config/scalafmt/.scalafmt.conf --stdin'"
let g:formatters_scala = ['scalafmt']

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

noremap <F5> :Autoformat<CR>
" }}}

"}}}

