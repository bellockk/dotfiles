" pathogen
filetype off  " To be updated after pathogen

" Determine which pathogen plugins to load
let g:pathogen_disabled = [ 'pathogen' ]    " don't load self

" Load pathogen bundles
call pathogen#infect()                      " load everyhting else
call pathogen#helptags()                    " load plugin help files

" Turns off strict vi compatibility
set nocompatible

" Turn off annoying error bells
set noerrorbells
set visualbell
set t_vb=

" Display scons files with python syntax
autocmd BufReadPre,BufNewFile SConstruct set filetype=python
autocmd BufReadPre,BufNewFile SConscript set filetype=python
autocmd BufReadPre,BufNewFile *.pyt      set filetype=python

" Create Machine Specific view folder.
let &viewdir = $HOME . '/.vim/view-' . substitute(hostname(), "\\..*", "", "")
if !isdirectory(expand(&viewdir))|call mkdir(expand(&viewdir), "p", 451)|endif

" Set the machine specific directory to store swap files.
let &dir = $HOME . '/.vim/temp-' . substitute(hostname(), "\\..*", "", "")
if !isdirectory(expand(&dir))|call mkdir(expand(&dir), "p", 451)|endif

" Undo History after File Close
if has("persistent_undo")
  set undofile
  let &undodir = $HOME . '/.vim/undo-' . substitute(hostname(), "\\..*", "", "")
  if !isdirectory(expand(&undodir))|call mkdir(expand(&undodir), "p", 451)|endif
  set undolevels=10000     " How many undos
  set undoreload=50000     " Number of lines to save for undo
endif

" Helps with editing multiple files.
set hidden

" Allows you to backspace over the listed character types
set backspace=indent,eol,start

" Avoid moving cursor to the beginning of the line when jumping around
set nostartofline

" Bump up the number of lines that can be yanked from default of 50
if has("viminfo")
  set viminfo='10000,<10000,s10,h
endif

" Do not wrap text in the middle of a word
set linebreak

" Turn on Wrap
set wrap

" Statusline
" custom status line, see :help 'statusline' for details 
if has("statusline") 
  set laststatus=2 " Always show the statusline
  set noshowmode " Hide the default mode text
  :set statusline=%<%f\ %h%w%m%r%y%{fugitive#statusline()}%=L:%l/%L\ (%p%%)\ C:%c%V\ B:%o\ F:%{foldlevel('.')}
endif
	
" Show matching [] and {}
set showmatch

" Attempt to determine the type of file based on its name and possible its
" contents.  use this to allow intelligent auto-indenting for each filtype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Show Line Numbers
set number

" Improves redrawing for newer computers
set ttyfast

" Number of search patterns and ex commands to remember
set history=500

" Better command-line completion
if has("wildmenu")
  set wildignore+=*.pyc,*.svn,*.git
  set wildmode=longest:full,list:full
  " set wildmode=longest,list
  set wildmenu
endif

" Shows the current vi mode
set showmode

" Enable use of the mouse for all modes
if has("mouse")
  set mouse=
endif

" Set title of window to file name
set title

" Turn on Incremental Search
set incsearch

" Highlight Searches
set hlsearch

" Show a visual line down the 80th column
if exists("+colorcolumn")
  set colorcolumn=80
endif

" Show partial commands in the last line of the screen
set showcmd

" Make a little more room for error messages
set cmdheight=2

" Use Spaces instead of tabs
set expandtab

" Helps with backspacing because of expandtab
set smarttab

" Number of spaces that a tab counts for
set softtabstop=4

" Number of spaces for autoindent
set shiftwidth=4

" Rounds indent to a multiple of shiftwidth
set shiftround

" Speed optimization, will not redraw the screen while playing a macro
set lazyredraw

if has("spell") 
  " Spelling Off by Default But Tweaked options below are for when it is turned
  " on
  highlight clear SpellBad
  highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
  highlight clear SpellCap
  highlight SpellCap term=underline cterm=underline
  highlight clear SpellRare
  highlight SpellRare term=underline cterm=underline
  highlight clear SpellLocal
  highlight SpellLocal term=underline cterm=underline
  
  " where it should get the dictionary files
  let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
endif

" Save Folds
set foldmethod=manual
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" Show fold column
set foldcolumn=1

" Syntastic options
let g:syntastic_python_checkers = ['flake8', 'pyflakes', 'pylint']
let g:syntastic_enable_highlighting = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = 'E'
let g:syntastic_style_error_symbol = 'S'
let g:syntastic_warning_symbol = 'W'
let g:syntastic_style_warning_symbol = 'S'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_config_file = '.clang_complete'
nmap <silent> <leader>y :SyntasticCheck<cr>
if ! &diff
    let g:syntastic_check_on_open = 1
endif

" CtrlP Settings
:let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
:let g:ctrlp_dotfiles = 0

" Airline Settings
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
