set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

"
"------------------
" Code Completions
"------------------
Bundle 'Shougo/neocomplcache'
Bundle 'mattn/emmet-vim'
" 括号彩虹 
" Bundle 'kien/rainbow_parentheses.vim'
" 括号引号补全
Bundle 'Raimondi/delimitMate'
" 快速切换括号，引号，标签
" Bundle 'tpope/vim-surround'
"
" Bundle 'ervandew/supertab'
"
"
"------------------
" snipmate
"------------------
" Bundle 'garbas/vim-snipmate'
" Bundle 'honza/vim-snippets'
" 代码片段补全、括号补全、加备注
Bundle 'drmingdrmer/xptemplate'
" snippets dependencies 
" Bundle 'MarcWeber/vim-addon-mw-utils'
" Bundle 'tomtom/tlib_vim'

"-----------------
" Fast navigation
"-----------------
" .. Bundle 'edsono/vim-matchit'
Bundle 'Lokaltog/vim-easymotion'

"--------------
" Fast editing
"--------------
Bundle 'scrooloose/nerdcommenter'
Bundle 'sjl/gundo.vim'
" .. 代码对齐 Bundle 'godlygeek/tabular'
Bundle 'nathanaelkane/vim-indent-guides'

"--------------
" IDE features
"--------------
Bundle 'scrooloose/nerdtree'
Bundle 'humiaozuzu/TabBar'
Bundle 'majutsushi/tagbar'
" .. Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim'
" .. Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-powerline'
" Bundle 'scrooloose/syntastic'
Bundle 'w0rp/ale'
" ..尾部空格 Bundle 'bronson/vim-trailing-whitespace'

"-------------
" Other Utils
"-------------
" Bundle 'humiaozuzu/fcitx-status'
" .. Bundle 'nvie/vim-togglemouse'

"----------------------------------------
" Syntax/Indent for language enhancement
"----------------------------------------
"------- web backend ---------
" .. Bundle '2072/PHP-Indenting-for-VIm'
"Bundle 'tpope/vim-rails'
" .. Bundle 'lepture/vim-jinja'
"Bundle 'digitaltoad/vim-jade'

"------- web frontend ----------
Bundle 'othree/html5.vim'
" Bundle 'tpope/vim-haml'
" .. Bundle 'pangloss/vim-javascript'
" Bundle 'kchmck/vim-coffee-script'
" .. Bundle 'nono/jquery.vim'
" Bundle 'groenewege/vim-less'
" Bundle 'wavded/vim-stylus'
" Bundle 'nono/vim-handlebars'

"------- markup language -------
Bundle 'tpope/vim-markdown'
" Bundle 'timcharper/textile.vim'

"------- Ruby --------
" Bundle 'tpope/vim-endwise'

"------- Go ----------
" .. Bundle 'fatih/vim-go'

"------- FPs ------
" Bundle 'wlangstroth/vim-racket'
" Bundle 'vim-scripts/VimClojure'
" Bundle 'rosstimson/scala-vim-support'
Plugin 'skywind3000/asyncrun.vim'
"--------------
" Color Schemes
"--------------
" Bundle 'rickharris/vim-blackboard'
" Bundle 'altercation/vim-colors-solarized'
" Bundle 'rickharris/vim-monokai'
" Bundle 'tpope/vim-vividchalk'
" Bundle 'Lokaltog/vim-distinguished'
" Bundle 'chriskempson/vim-tomorrow-theme'
" Bundle 'fisadev/fisa-vim-colorscheme'

filetype plugin indent on     " required!

