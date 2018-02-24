source ~/.vim/bundles.vim
" ==========================  ==========================  ==========================  ==========================
" xtemplate、ale没同步到ubuntu下的vim
" bundles 去掉了snipmate
" ==========================  ==========================  ==========================  ==========================
"
"-------- -------- -------- -------- -------- --------
                    " vimdiff配色
"-------- -------- -------- -------- -------- --------
" 新增的行
hi DiffAdd    ctermbg=235  ctermfg=108  guibg=#262626 guifg=#87af87 cterm=reverse gui=reverse
" 变化的行
hi DiffChange ctermbg=235  ctermfg=103  guibg=#262626 guifg=#8787af cterm=reverse gui=reverse
" 删除的行
hi DiffDelete ctermbg=235  ctermfg=131  guibg=#262626 guifg=#af5f5f cterm=reverse gui=reverse
" 变化的文字
hi DiffText   ctermbg=235  ctermfg=208  guibg=#262626 guifg=#ff8700 cterm=reverse gui=reverse


"-------- -------- -------- -------- -------- --------
                    "Xtemplate
let g:xptemplate_vars="author=m_kepler&email=hellohuangjinjie@gmail.com"
let g:xptemplate_vars="BRfun= &BRloop= &SParg= "
let g:xptemplate_brace_brace_complate = "([{\""
"-------- -------- -------- -------- -------- --------
"
"-------- -------- -------- -------- -------- --------
                    "ALE
"-------- -------- -------- -------- -------- --------
" 之前保存文件一致很久是因为语法检查，现在换成ale好多了
" http://blog.csdn.net/demorngel/article/details/69052789
"始终开启标志列
let g:ale_sign_column_always = 0
let g:ale_set_highlights = 0
" let g:ale_lint_on_text_changed = 'never' "文件内容发生变化时不进行检查
let g:ale_lint_on_enter = 1 "打开文件时进行检查
"自定义error和warning图标
let g:ale_fix_on_save = 2
let g:ale_sign_error = '·'
let g:ale_sign_warning = '·'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{ALEGetStatusLine()}
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>4触发/关闭语法检查
" nmap <Leader>4 :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
" nmap <Leader>d :ALEDetail<CR>

"==========================
let mapleader=";"
" 我很多快捷键都是<leader>+字母，但是这样的话会慢一点，可能是因为在等命令，所以还是用功能键吧
:noremap <Leader>1 :call asyncrun#quickfix_toggle(8,1)<cr>
:noremap <Leader>2 :call asyncrun#quickfix_toggle(8,0)<cr>
" :vimgrep也可以在当前文件中查找包含的字符串:`:vimgrep keyword *`
" quickfix有内容时，自动打开
" 171210 AsyncRun!未加入到ubuntu下的vim
" Plugin 'skywind3000/asyncrun.vim'
augroup vimrc
    autocmd QuickFixCmdPost * botright copen 8
augroup END
"
"-------- -------- -------- -------- -------- --------
                    "title
"-------- -------- -------- -------- -------- --------
function AddTitle()
    call append(0,"/***********************************************************")
    call append(1,"* Author       : M_Kepler")
    call append(2,"* EMail        : m_kepler@foxmail.com")
    call append(3,"* Last modified: ".strftime("%Y-%m-%d %H:%M:%S"))
    call append(4,"* Filename     : ".expand("%:t"))
    call append(5,"* Description  :")
    call append(6,"**********************************************************/")
    call append(7,"")
    echohl WarningMsg | echo "Successful in adding the copyright."|echohl None
endfunction

function UpdateTitle()
    normal m'
    execute '/* Last modified:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M:%S")@'
    normal ''
    normal mk
    execute '/* Filename     :/s@:.*$@\=": ".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copyright." | echohl None
endfunction

function TitleDet()
    let n=1
    while n < 10
        let line = getline(n)
        if line =~'^\*\s*\S*Last\smodified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction

:noremap <leader>3 :call TitleDet() <CR>

"-------- -------- -------- -------- -------- --------
                    "autospace
"设置= + - * 前后自动插入空格
"-------- -------- -------- -------- -------- --------
" inoremap ( ()<ESC>i
" inoremap [ []<ESC>i
" inoremap { {}<ESC>i
" inoremap < <><ESC>i
au FileType python inoremap <buffer>, ,<space>
let g:equ=1
if exists("g:equ")
    " if &filetype == 'c' && &filetype == 'cpp'
    :inoremap << <c-r>=EqualSign('<<')<CR>
    :inoremap >> <c-r>=EqualSign('>>')<CR>
    :inoremap + <c-r>=EqualSign('+')<CR>
    :inoremap - <c-r>=EqualSign('-')<CR>
    :inoremap * <c-r>=EqualSign('*')<CR>
    :inoremap = <c-r>=EqualSign('=')<CR>
    :inoremap += <c-r>=EqualSign('+=')<CR>
    :inoremap == <c-r>=EqualSign('==')<CR>
    " endif
endif


function! EqualSign(char)
    if a:char =~ '=' && getline('.') =~ ".*("
        return a:char
    endif
    let ex1 = getline('.')[col('.') - 3]
    let ex2 = getline('.')[col('.') - 2]
    if ex1 =~ "[-=+><>\/\*]"
        if ex2 !~ "\s"
            return "\<ESC>i".a:char."\<SPACE>"
        else
            return "\<ESC>xa".a:char."\<SPACE>"
        endif
    else
        if ex2 !~ "\s"
            return "\<SPACE>".a:char."\<SPACE>\<ESC>a"
        else
            return a:char."\<SPACE>\<ESC>a"
        endif
    endif
endf

" 状态栏
let g:airline#extensions#tabline#enabled = 1
"
"-------- -------- -------- -------- -------- --------
                    " 折叠
"-------- -------- -------- -------- -------- --------
"开启折叠，并设置空格开关
set foldenable
set foldmethod=syntax
" set foldmethod=indent
"设置折叠区宽度
set foldcolumn=0
"设置折叠层数
setlocal foldlevel=1
"设置自动关闭折叠
"set foldclose=all
"设置空格开关折叠
nnoremap <space> @=((foldclosed(line('.'))<0)?'zc':'zo')<CR>
"设置刚开始时不自动折叠
set foldlevelstart=99
"搜索和undo时不展开设置好的折叠
set foldopen-=search
set foldopen-=undo


"-------- -------- --------
                   " 快捷键
"-------- -------- --------
let g:ctrlp_map = '<Leader>o'
set relativenumber
let g:EasyMotion_leader_key = '<Leader>'
nnoremap <Leader>p :set invpaste paste?<CR>
nmap <Leader>tg :TagbarToggle<cr>
nmap <Leader>tn :NERDTreeToggle<cr>
nmap <Leader>u :GundoToggle<cr>
nnoremap <Leader>wh <c-w>h
nnoremap <Leader>wl <c-w>l
nnoremap <Leader>wj <c-w>j
nnoremap <Leader>wk <c-w>k
nnoremap <Leader> tl :TaskList<cr>
nmap <Leader>n :lnext<cr>
nmap <Leader>p :lpre<cr>
nnoremap <Leader>bn :bn<cr>
nnoremap <Leader>bp :bp<cr>
nnoremap <Leader>x :bd<cr>
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <leader>a :Ack -i<space>

"-------- -------- -------- -------- -------- --------
                    " ColorScheme "按<Leader>yy键依次修改颜色主题
"-------- -------- -------- -------- -------- --------
let g:csnum = 0
map <Leader>yy :call ChangeColorScheme()<CR>
function! ChangeColorScheme()
    if g:csnum == 0
        :colorscheme torte
        :let g:csnum = 1
    elseif  g:csnum == 1
        :colorscheme murphy
        :let g:csnum = 2
    elseif  g:csnum == 2
        :colorscheme desert
        :let g:csnum = 3
    elseif  g:csnum == 3
        :colorscheme murphy
        :let g:csnum = 4
    elseif  g:csnum == 4
        :colorscheme delek
        :let g:csnum = 5
    elseif  g:csnum == 5
        :colorscheme elflord
        :let g:csnum = 6
    elseif  g:csnum == 6
        :colorscheme evening
        :let g:csnum = 7
    elseif  g:csnum == 7
        :colorscheme koehler
        :let g:csnum = 8
    elseif  g:csnm == 9
        :colorscheme dracula
    else
        :colorscheme default
        :let g:csnum = 0
    endif
endfunction

"-------- -------- -------- -------- -------- --------
"C,C++,Fortran,Python,java,Latex,sh等按<F5>编译运行
"-------- -------- -------- -------- -------- --------
map <F5> :call CompileAndRun()<CR>
func! CompileAndRun()
    :cd %:p:h
    exec "w"
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
        " exec AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
        exec "AsyncRun! g++ % -o %<; time ./%<"
    elseif &filetype == 'python'
        " exec "AsyncRun! python %"
        exec "! python %"
    elseif &filetype == 'ncl'
        exec "!ncl %"
    elseif &filetype == 'html'
        exec "!google-chrome %"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'fortran'
        exec "!gfortran % -o %<"
        exec "! ./%<"
    elseif &filetype == 'tex'
        exec "!xelatex -shell-escape %<"
        exec "!xelatex -shell-escape %<"
    elseif &filetype == 'sh'
        :!sh ./%
    endif
endfunc

" ==========================  ==========================  ==========================  ==========================

" encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

" enable filetype dectection and ft specific plugin/indent
filetype plugin indent on

" enable syntax hightlight and completion
syntax on

"--------
" Vim UI
"--------
" color scheme
set background=light
" colorscheme space-vim-dark
" colorscheme dracula
colorscheme default
" colorscheme blues
" colorscheme molokai
" colorscheme monokai
" colorscheme onedark
" colorscheme solarized
" colorscheme tender


" highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" search
set incsearch
"set highlight 	" conflict with highlight current line
set ignorecase
set smartcase

" editor settings
set history=1000
set nocompatible
set confirm                                                       " prompt when existing from an unsaved file
set backspace=indent,eol,start                                    " More powerful backspacing
set t_Co=256                                                      " Explicitly tell vim that the terminal has 256 colors "
set mouse=a                                                       " use mouse in all modes
set report=0                                                      " always report number of lines changed                "
set nowrap                                                        " dont wrap lines
set scrolloff=5                                                   " 5 lines above/below cursor when scrolling
set number                                                        " show line numbers
set showmatch                                                     " show matching bracket (briefly jump)
set showcmd                                                       " show typed command in status bar
set title                                                         " show file in titlebar
set laststatus=2                                                  " use 2 lines for the status bar
set matchtime=2                                                   " show matching bracket for 0.2 seconds
set matchpairs+=<:>                                               " specially for html
" set relativenumber

" Default Indentation
set autoindent
set smartindent     " indent when
set tabstop=4       " tab width
set softtabstop=4   " backspace
set shiftwidth=4    " indent width
" set textwidth=79
" set smarttab
set expandtab       " expand tab to space

autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120

" syntax support
autocmd Syntax javascript set syntax=jquery   " JQuery syntax support
" js
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

"-----------------
" Plugin settings
"-----------------
" Rainbow parentheses for Lisp and variants
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
autocmd Syntax lisp,scheme,clojure,racket RainbowParenthesesToggle

" tabbar
let g:Tb_MaxSize = 2
let g:Tb_TabWrap = 1

hi Tb_Normal guifg=white ctermfg=white
hi Tb_Changed guifg=green ctermfg=green
hi Tb_VisibleNormal ctermbg=252 ctermfg=235
hi Tb_VisibleChanged guifg=green ctermbg=252 ctermfg=white

" easy-motion
" let g:EasyMotion_leader_key = '<Leader>'

" Tagbar
let g:tagbar_left=0
let g:tagbar_width=30
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
" tag for coffee
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }

  let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'sort' : 0,
    \ 'kinds' : [
        \ 'h:sections'
    \ ]
    \ }
endif

" Nerd Tree
let NERDTreeMinimalUI=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDChristmasTree=0
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos = "left"

" nerdcommenter
let NERDSpaceDelims=1
" nmap <D-/> :NERDComToggleComment<cr>
let NERDCompactSexyComs=1

" ZenCoding
let g:user_emmet_expandabbr_key='<C-j>'

" powerline
let g:Powerline_symbols = 'fancy'


" NeoComplCache

let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_quick_match=1
" let g:neoComplcache_disableautocomplete=1
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
set completeopt-=preview

imap <C-k> <Plug>(neocomplcache_snippets_force_expand)
smap <C-k> <Plug>(neocomplcache_snippets_force_expand)
imap <C-l> <Plug>(neocomplcache_snippets_force_jump)
smap <C-l> <Plug>(neocomplcache_snippets_force_jump)

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType c setlocal omnifunc=ccomplete#Complete
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.erlang = '[a-zA-Z]\|:'
let g:neocomplcache_enable_at_startup = 1

" SuperTab
" let g:SuperTabDefaultCompletionType='<c-n>'
" let g:SuperTabDefaultCompletionType = '<C-X><C-U>'
" let g:SuperTabRetainCompletionType=2


" ctrlp
set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store  " MacOSX/Linux
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

" Keybindings for plugin toggle
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
nmap <F4> :IndentGuidesToggle<cr>
nmap  <D-/> :
nnoremap <leader>a :Ack
nnoremap <leader>v V`]

"------------------
" Useful Functions
"------------------
" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif

" w!! to sudo & write a file
cmap w!! %!sudo tee >/dev/null %

" Quickly edit/reload the vimrc file
" nmap <silent> <leader>ev :e $MYVIMRC<CR>
" nmap <silent> <leader>sv :so $MYVIMRC<CR>

" sublime key bindings
nmap <D-]> >>
nmap <D-[> <<
vmap <D-[> <gv
vmap <D-]> >gv

" eggcache vim
nnoremap ; :
:command W w
:command WQ wq
:command Wq wq
:command Q q
:command Qa qa
:command QA qa

" for macvim
if has("gui_running")
    set go=aAce  " remove toolbar
    "set transparency=30
    set guifont=Monaco:h13
    set showtabline=2
    set columns=140
    set lines=40
    noremap <D-M-Left> :tabprevious<cr>
    noremap <D-M-Right> :tabnext<cr>
    map <D-1> 1gt
    map <D-2> 2gt
    map <D-3> 3gt
    map <D-4> 4gt
    map <D-5> 5gt
    map <D-6> 6gt
    map <D-7> 7gt
    map <D-8> 8gt
    map <D-9> 9gt
    map <D-0> :tablast<CR>
endif
