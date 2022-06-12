if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set bs=indent,eol,start		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

"if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
"endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"


" Tweaks
set number
colo desert
"colo delek
" Show tab characters or not. :set list! will toggle tab characters on and off
set nolist
set showcmd
"set list lcs=tab:\>\ 
highlight Visual cterm=reverse ctermbg=NONE

" Custom keybinds
nnoremap <CR> i<CR><Esc>
"nnoremap <Space> i<Space><Esc>l
nnoremap <Space> za					" use spacebar to fold/unfold
nnoremap <Tab> i<Tab><Esc>l
nnoremap <BS> hx<Esc>
nnoremap ,/ @="mc0i//\<lt>Esc>`cj"<CR>
nnoremap ,< mc^i<!--<Space><Esc>$a<Space>--><Esc>`clllll
nnoremap ,# @="mc0i#\<lt>Esc>`cj"<CR>
nnoremap ," @="mc0i\"\<lt>Esc>`cj"<CR>
nnoremap ,- @="mc0i//-----------------------------------------------------------------------------\<lt>Esc>`cj"<CR>
nnoremap ,. @="mc0i//.............................................................................\<lt>Esc>`cj"<CR>
inoremap {{ {<CR><Tab><Esc>mci<CR>}<Esc>`ca<Tab>

nnoremap ,j mc^i/*<Space><Esc>$a<Space>*/<Esc>`clll
nnoremap ,,j mcO/*------------------------------------------------------------------------*/<Esc>jI/*<Space><Esc>A<Space>*/<CR>/*------------------------------------------------------------------------*/<Esc>`clll

nnoremap ,s mc^i###<Space><Esc>$a<Space>###<Esc>`clll
nnoremap ,,s mcO########################################################################<Esc>jI###<Space><Esc>A<Space>###<CR>########################################################################<Esc>`clll

set ignorecase
set smartcase

" Navigating splits
set splitbelow
set splitright
"map <S-J> :tabp<CR>
"map <S-K> :tabn<CR>
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

set shiftwidth=2

set foldmethod=marker
	autocmd filetype html set foldmarker=<!--{{{-->,<!--}}}-->
"	autocmd BufRead,BufNewFile *.html set foldmarker=<!--{{{-->,<!--}}}-->

" Highlight bad whitespace (not sure if this is working
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhiteSpace /\s\+$/


" ---- For Python ----
au BufNewFile,BufRead *.py
	\ set tabstop=4
	\ | set softtabstop=4
	\ | set shiftwidth=4
	\ | set textwidth=79
	\ | set expandtab
	\ | set fileformat=unix
	\ | set foldmethod=indent
	"\ | set foldlevel=99
"au BufNewFile,BufRead *.py
"	\ set tabstop=4
"	\ softtabstop=4
"	\ shiftwidth=4
"	\ textwidth=79
"	\ expandtab
"	\ fileformat=unix
"	\ foldmethod=indent
"	\ foldlevel=99

"set softtabstop=4
"set expandtab
"set shiftwidth=4	" indent a line in normal mode using >> or <<, and in insert mode using ctrl+t or ctrl+d
"set tabstop=4		" we want the tab stop to be the same as shiftwidth

" ---- end Python ----


" Plugins and addons

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" vim.gtk/gvim: map alt+[hjkl] to normal terminal behaivior
" source: https://stackoverflow.com/questions/26366055/how-to-make-alt-works-in-gvim-as-in-vim
if has("gui_running")
    " inoremap == 'ignore any other mappings'
    inoremap <M-h> <ESC>h
    inoremap <M-j> <ESC>j
    inoremap <M-k> <ESC>k
    inoremap <M-l> <ESC>l

    " uncomment to disable Alt+[menukey] menu keys (i.e. Alt+h for help)
    set winaltkeys=no " same as `:set wak=no`

    " uncomment to disable menubar
    set guioptions -=m

    " uncomment to disable icon menubar
    set guioptions -=T

endif
