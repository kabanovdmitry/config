"
" vim:fdm=marker

" Preamble - nocompatible {{{
" Use Vim settings, rather than Vi settings.
set nocompatible
" }}}

" Plugins (managed by vim plug) {{{
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'
Plug 'junegunn/vim-easy-align'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-utils/vim-husk'  " Mappings for command mode in Emacs style.

Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" Snippets.
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Turn on CAPS LOCK.
Plug 'tpope/vim-capslock'

" Color schemes.
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'

" Git integration.
Plug 'tpope/vim-fugitive'

" Fix python indentation.
Plug 'hynek/vim-python-pep8-indent'

" Plugins that improve support of different file types.
Plug 'lervag/vimtex'  " latex support
Plug 'tmux-plugins/vim-tmux' " syntax highlighting for `.tmux.conf`

" Plugin for markdown. Depends on `tabular`.
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'

" Add plugins to &runtimepath.
call plug#end()
runtime macros/matchit.vim
" }}}

" Options for the editor itself {{{
" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Enable syntax highlighting.
syntax enable

" Autoindent when starting new line, or using `o` or `O`.
set autoindent

" Backspace over autoindent, line breaks, start of insert.
set backspace=indent,eol,start

" Don't scan included files. The .tags file is more performant.
set complete-=i

" Use 'shiftwidth' when using `<Tab>` in front of a line.
" By default it's used only for shift commands (`<`, `>`).
set smarttab

" Default indentation settings.
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Set `UTF-8` encoding.
set encoding=utf-8

" Allow for mappings including `Esc`, while preserving
" zero timeout after pressing it manually.
set ttimeout
set ttimeoutlen=100

" Hide backup and swap files by putting them in the `tmp` directory.
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//

" Allow to switch between buffers even if the current buffer is modified.
set hidden

" Autocomplete commands using nice menu in place of window status line.
" Enable `Ctrl-N` and `Ctrl-P` to scroll through matches.
set wildmenu

" Autocomplete by choosing next full match.
set wildmode=full

" Ignore patterns for filename completion.
" Archive patterns.
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.tar.xz,*.rar
" Python patterns.
set wildignore+=*.pyc,*/__pycache__/*,*.so

" Stop showing annoying preview window during autocompletion.
set completeopt-=preview

set keymap=russian-jcukengost
set iminsert=0
set imsearch=0

" Check spelling.
set spell
set spelllang=en_us,ru

" Delete comment character when joining commented lines.
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" Search upwards for `tags` file instead only locally.
if has('path_extra')
    setglobal tags-=./tags tags^=./tags;
endif

" Reload unchanged files automatically.
set autoread

" Map <Leader> key to <Space> key.
let mapleader = "\<Space>"

" Map <LocalLeader> key to backslash key.
let maplocalleader = "\\"

" Make `Y` to work from the cursor to the end of line, which is more logical
" (compare: C, D) but not Vi-compatible.
map Y y$

" Mapping for saving current buffer to file.
" Shortcut `fs` stands for "file, save".
nmap <Leader>fs :update<CR>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" }}}

" Search options {{{
set hlsearch

" Use mapping to clear the highlighting of `:set hlsearch`.
nnoremap <silent> <Leader>z :nohlsearch<CR>

" Turn on incremental search.
set incsearch

" Use smart detection of case-sensitive or case-insensitive search.
set ignorecase
set smartcase

" Set minimal number of screen lines to keep above and below the cursor.
set scrolloff=1
" }}}

" Visual appearance options {{{
if has('mac')
    set background=dark
    colorscheme gruvbox
else
    if $COLORTERM == 'gnome-terminal'
        let g:solarized_termcolors=16
        set t_Co=16
    endif

    set background=dark
    colorscheme solarized
endif

" Font
if has("gui_macvim")
    set guifont=Menlo:h18
endif

if has("gui_gtk2")
    set guifont=Cousine\ 14
endif

" Highlight line under cursor.
set cursorline

if exists("+colorcolumn")
    set colorcolumn=80
endif

" Show line numbers.
set number

" Always show window status line, even if there's only one window.
set laststatus=2

" Turn off showing current mode in command line.
set noshowmode

" Enable visual bell instead of beeping.
set visualbell

" Shortcut for rapidly toggle 'set list'
nmap <Leader>lws :set list!<CR>
" Custom symbols for invisible symbols such as tab and EOL
set listchars=tab:»\ ,eol:¬

" Show partial command in the last line of the screen.
set showcmd
" }}}

" Options for CtrlP {{{
let g:ctrlp_cmd = 'CtrlPCurWD'

" Configure `CtrlP` to use `ag` or `git` for listing files instead of using
" Vim's `globalpath()`.
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
" }}}

" Options for syntastic {{{
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_error = 1
let g:syntastic_stl_format = 'Syntastic: %F (%t)'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_tex_checkers = ['lacheck']
" }}}

" Options for ultisnips {{{
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-S-j>"

" Options for python.
let g:ultisnips_python_quoting_style="single"
let g:ultisnips_python_triple_quoting_style="double"
let g:ultisnips_python_style="numpy"
" }}}

" Options for YouCompleteMe {{{
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_path_to_python_interpreter = "/usr/bin/python"
let g:ycm_python_binary_path = 'python'
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 1
" }}}

" Options for vim-airline {{{
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_powerline_fonts=0
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'SV',
  \ '' : '^V',
  \ 's'  : 'S',
  \ 'S'  : 'SS',
  \ '' : '^S',
  \ }
" }}}

" Options for vimtex {{{
let g:vimtex_fold_enabled = 0
let g:vimtex_view_method='mupdf'
" }}}

" Options for `plasticboy/vim-markdown` {{{
let g:vim_markdown_math=1
let g:vim_markdown_folding_disabled=1
" }}}
