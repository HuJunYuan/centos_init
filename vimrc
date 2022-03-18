set ts=4
set expandtab
set autoindent

filetype on                               "启用文件类型侦测
filetype plugin on                        "针对不同的文件类型加载对应的插件
filetype plugin indent on                 "启用缩进
filetype indent on

"  文件编码
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=gb2312
set termencoding=utf-8

set hlsearch

"缩进指示线"
let g:indentLine_char='┆'
let g:indentLine_enabled = 1

autocmd FileType make set noexpandtab

set number
set ruler

set nolinebreak
set background=light
set showmatch
set autochdir
set shortmess=atI

set t_Co=256
colorscheme desert


hi LineNr ctermfg=245 ctermbg=255
set cursorline ""突出显示当前行""
" set cursorcolumn  "突出显示当前列"
hi CursorLine ctermbg=235 cterm=NONE guibg=Grey40
syntax on
" hi Search term=bold ctermfg=green  ctermbg=red
hi Search term=standout cterm=bold ctermfg=7 ctermbg=1 guifg=White guibg=Red

" 高亮括号与运算符等
""" au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,javascript} call CSyntaxAfter()
" 设置终端对齐线颜色
let g:indentLine_color_term = 239
" -----------------------------------------------------------------------------
"  < 其它配置 >
" -----------------------------------------------------------------------------
set writebackup                             "保存文件前建立备份，保存成功后删除该备份
set nobackup                                "设置无备份文件
set noswapfile                              "设置无临时文件
set vb t_vb=                                "关闭提示音

" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<cr>:noh<cr>

" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<cr>:noh<cr>

" 状态栏 by dubin
"set laststatus=2      " 总是显示状态栏
"highlight StatusLine cterm=bold ctermfg=yellow ctermbg=gray
" " 获取当前路径，将$HOME转化为~
"function! CurDir()
"    let curdir = substitute(getcwd(), $HOME, "~", "g")
"    return curdir
"endfunction
" set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\
"set statusline=[%n]\ %f%m%r%h\ \|\ %{CurDir()}\ \|%=\|\ %c,\ %l/%L\ %p%%\ \|\ ascii=%b\ hex=0x%B%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %-16{strftime(\"%Y-%m-%d\ %H:%M:%S\ \")}


set ignorecase                                        "搜索模式里忽略大小写
set smartcase                                         "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
" set noincsearch                                       "在输入要搜索的文字时，取消实时匹配


" 每行超过80个的字符用下划线标示
" au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)
" 打开文件时，光标自动跳转到上次关闭的位置
autocmd BufReadPost *
            \ if line("'\"")>0&&line("'\"")<=line("$") |
            \   exe "normal g'\"" |
            \ endif

" ctrlp plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim

"将键盘上的F4功能键映射为添加作者信息的快捷键
map <F4> ms:call AddTitle()<cr>'s
function AddTitle()
        call append(2,"'''")
        call append(3," * *****************************************************************/")
        call append(4," * Author :hujyyf")
        call append(5," * Email  : hujyyf@seeyon.com")
        call append(6," * Created : ".strftime("%Y-%m-%d %H:%M"))
        call append(7," * Last modified : ".strftime("%Y-%m-%d %H:%M"))
        call append(8," * Filename : ".expand("%:t"))
        call append(9," * Description : ")
        call append(10," * Args : ")
        call append(11," * Returns : ")
        call append(12," * ****************************************************************/")
        call append(13,"'''")
        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf

autocmd FileWritePre,BufWritePre *.py ks|call DateInsert()|'s
function! DateInsert()
call cursor(7,1)
if search('Last modified') != 0
    let line = line('.')
    call setline(line," * Last modified: " . strftime("%Y-%m-%d %H:%M:%S"))
endif
endfunction
"
"-------------------------------------------------------------------------------

auto BufNewFile *.py call PythonHeader()

func PythonHeader()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
    call append(2, "")
    call append(3, "from __future__ import unicode_literals")
    call append(4, "from __future__ import absolute_import")
endf


