set clipboard=unnamedplus
let &t_ut=''
set autochdir

set number
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=10
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set showcmd
set ignorecase
set smartcase
set shortmess+=c
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
set updatetime=1000
set virtualedit=block

" 取消临时文件
set noswapfile

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" 插件
call plug#begin('~/.config/nvim/plugged')
" 文件树
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


" 主题
Plug 'liuchengxu/space-vim-theme'
Plug 'rakr/vim-one'
Plug 'ajmwagar/vim-deus'

" File Icon
Plug 'ryanoasis/vim-devicons'

" 高亮
Plug 'jaxbot/semantic-highlight.vim'
Plug 'RRethy/vim-illuminate'

Plug 'elzr/vim-json'

" 括号
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'

" Code Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git
Plug 'airblade/vim-gitgutter'


Plug 'gcmt/wildfire.vim'
" 符号对齐:
Plug 'junegunn/vim-easy-align'

call plug#end()

" 主题设置
" enable true colors support
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"color one
color deus
" color space-vim-theme



" NerdTree 设置
" autocmd vimenter * NERDTree
" 打开时自动将光标置为右侧
" wincmd w
" autocmd VimEnter * wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 打开vim时如果没有文件自动打开NerdTree
autocmd vimenter * if !argc() | NERDTree | endif
wincmd w
autocmd VimEnter * wincmd w
" 不显示隐藏文件
let g:NERDTreeHidden = 0
" 过滤: 所有指定文件和文件夹不显示
let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '\.vscode', '__pycache__']
" 美化UI
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" rainbow 设置
" 默认开启
let g:rainbow_active = 1

" vim-illuminate
let g:Illuminate_delay = 750
hi illuminatedWord cterm=undercurl gui=undercurl

" COC
let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-json', 'coc-gitignore', 'coc-git']

" GitGutter
let g:gitgutter_signs = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
autocmd BufWritePost * GitGutter