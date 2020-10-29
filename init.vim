set clipboard=unnamedplus
let &t_ut=''
set autochdir

" 自动读取已修改文件
set autoread
" 行号
set number
set relativenumber
" 插入模式下按下Tab键时，输入到Vim中的都是空格
set noexpandtab
" 选项设置按下Tab键时，缩进的空格个数
set tabstop=2
set shiftwidth=2
set softtabstop=2
" 新增加的行和前一行具有相同的缩进形式
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
" 设置在屏幕最后一行显示 (部分的) 命令
set showcmd
" 在插入、替换和可视模式里，在最后一行提供消息
set showmode
" 如果搜索模式中包含大写字母，Vim就会认为当前的查找(搜索)是区分大小写的
" 如果搜索模式中不包含任何大写字母，Vim 则会认为搜索应该不区分大小写
set ignorecase
set smartcase
set shortmess+=c
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
set updatetime=100
set virtualedit=block

set nobackup
set noswapfile
set noundofile
set nowritebackup
filetype plugin on

" 状态栏
set laststatus=2
" 取消临时文件
set noswapfile

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" Compile function
noremap <C-r> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		CocCommand flutter.run
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc

" 按键映射
" 行首, 行尾
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
nnoremap H ^
nnoremap L $
" 取消撤销
nnoremap U <C-r>
" 复制到行尾
nnoremap Y y$

" autocmd生成文件头
autocmd BufNewFile *.py exec ":call PythonTemplate()"
autocmd BufNewFile *.h,*.cpp,*.cc exec ":call CppTemplate()"
autocmd BufNewFile *.sh exec ":call ShellTemplate()"
" 自动将光标定位到末尾
autocmd BufNewFile * normal G

func! PythonTemplate()
	call setline(1,          "# -*- coding: utf-8 -*-")
	call append(line("."),   "# Date     : ".strftime("%Y/%m/%d"))
	call append(line(".")+1, "# Author   : zhangzhe7")
	call append(line(".")+2, "# Project  : ")
	call append(line(".")+3, "# File     ：".expand("%"))
	call append(line(".")+4, "# Usage：  : ")
	call append(line(".")+5, "")
endfunc

func! ShellTemplate()
	call setline(1,"#!/bin/bash")
	call append(line("."), "# Author : zhangzhe7")
	call append(line(".")+1, "# Usage : nohup sh -x ".expand("%"))
	call append(line(".")+2, "")
endfunc

func! CppTemplate()
	call setline(1,"#!/bin/bash")
	call append(line("."), "# Author : zhangzhe7")
	call append(line(".")+1, "# Usage : nohup sh -x ".expand("%"))
	call append(line(".")+2, "")
endfunc

" 为不同的文件类型设置缩进
autocmd Filetype python setlocal tabstop=4
autocmd Filetype sh setlocal tabstop=2
autocmd Filetype go setlocal tabstop=2 smartindent
autocmd Filetype cpp setlocal tabstop=2 smartindent

" 插件
call plug#begin('~/.config/nvim/plugged')
" 文件树
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" 状态栏
Plug 'liuchengxu/eleline.vim'

" 注释
Plug 'tpope/vim-commentary'

" 主题
Plug 'bpietravalle/vim-bolt'
Plug 'bling/vim-bufferline'
Plug 'ajmwagar/vim-deus'

" 移动
Plug 'easymotion/vim-easymotion'

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
Plug 'tpope/vim-fugitive'

Plug 'mg979/vim-xtabline'

Plug 'gcmt/wildfire.vim'
" 符号对齐:
Plug 'junegunn/vim-easy-align'

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'tell-k/vim-autopep8'

" Go
" Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }

call plug#end()

" 主题设置
" enable true colors support
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

color deus

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
nmap tt :NERDTreeToggle<CR>

" rainbow 设置
" 默认开启
let g:rainbow_active = 1

" vim-illuminate
let g:Illuminate_delay = 750
hi illuminatedWord cterm=undercurl gui=undercurl

" COC
let g:coc_global_extensions = ['coc-sh', 'coc-python', 'coc-vimlsp', 'coc-json', 'coc-gitignore', 'coc-git', 'coc-go']

" Tab 选择
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 重命名
nmap <cr>q <Plug>(coc-rename)

" Add Golang Missing Import On Save
autocmd BufWritePre *.go :call CocAction('organizeImport')

" GitGutter
let g:gitgutter_signs = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
autocmd BufWritePost * GitGutter

" Vim-Fugitive
set statusline+=%{FugitiveStatusline()}

" vim-autopep8
autocmd FileType python noremap <buffer> <C-l> :call Autopep8()<CR>
" 取消对比窗口
let g:autopep8_disable_show_diff=1

" ===
" === xtabline
" ===
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
