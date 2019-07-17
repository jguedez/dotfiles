set nocompatible               " be iMproved
filetype off                   " required!

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Core plugins
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-unimpaired'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mattn/emmet-vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'ervandew/supertab'
" Plugin 'tomtom/tlib_vim'
Plugin 'jgdavey/tslime.vim'
" Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/fzf.vim'
Plugin 'tomasr/molokai'

" Snippets plugins
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'

" Syntax plugins
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'chrisbra/csv.vim'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'cespare/vim-toml'
Plugin 'ambv/black'

" Git plugins
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on     " required!

"############################################
syntax on
color molokai
nnoremap ; :
nnoremap : ;
set ls=2
set t_Co=256
set relativenumber
set number

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set foldmethod=indent
set foldnestmax=2

map <left> <nop>
map <right> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
noremap <left> gT
noremap <right> gt
noremap <up> :tabnew <CR>
noremap <down> :bd <CR>

let @d='0Oimport ipdb; ipdb.set_trace()0'

let NERDTreeShowBookmarks=1
nnoremap <silent> <F4> :NERDTreeToggle<CR>
if filereadable($VIMRUNTIME . "/macros/matchit.vim")
 source $VIMRUNTIME/macros/matchit.vim
endif
let b:match_debug=1

augroup cursorline
    autocmd!
    au BufEnter * setlocal cursorline
    au BufLeave * setlocal nocursorline
augroup END

" tmux integration options
let g:tmux_navigator_no_mappings = 1
noremap <silent> <c-h> :TmuxNavigateLeft<cr>
noremap <silent> <c-j> :TmuxNavigateDown<cr>
noremap <silent> <c-k> :TmuxNavigateUp<cr>
noremap <silent> <c-l> :TmuxNavigateRight<cr>
noremap <silent> <c-\> :TmuxNavigatePrevious<cr>

" tslime - https://github.com/jgdavey/tslime.vim
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars

" helpers for clipboard/copy/paste
set pastetoggle=<F2>
set clipboard=unnamedplus
" copy to clipboard on exit, note it will not work on suspend :(
" https://stackoverflow.com/questions/6453595/prevent-vim-from-clearing-the-clipboard-on-exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" supertab
let g:SuperTabDefaultCompletionType = "context"

" emmet just for html/css
let g:user_emmet_install_global = 0
augroup plugin_emmet
    autocmd!
    autocmd FileType html,css,htmldjango EmmetInstall
augroup END

" filetype overrides
augroup filetype_custom
    autocmd!
    autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" http://vim.wikia.com/wiki/Forcing_Syntax_Coloring_for_files_with_odd_extensions
augroup filetypedetect
    au BufRead,BufNewFile *.playbook set filetype=yaml
augroup END

" convenience mapping
nnoremap - dd
nnoremap <space> V
noremap _ g_

" " vimscript the hard way
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
iabbrev ORder Order
inoremap jj <esc>
nnoremap / /\v

" FZF
" activate fzf
nnoremap <silent> <C-p> :FZF<CR>
nnoremap <silent> <leader>t :Windows<CR>
nnoremap <silent> <leader>l :Lines<CR>

" YouCompleteMe config
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" re-define blacklist w/o 'text' to enable completion of text files
" https://github.com/Valloric/YouCompleteMe/#the-gycm_filetype_blacklist-option
let g:ycm_filetype_blacklist = {
      \ 'tagbar': 1,
      \ 'notes': 1,
      \ 'markdown': 1,
      \ 'netrw': 1,
      \ 'unite': 1,
      \ 'vimwiki': 1,
      \ 'pandoc': 1,
      \ 'infolog': 1,
      \ 'mail': 1
      \}

" make YCM compatible with UltiSnips (using supertab)
" https://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme/22253548#22253548
let g:ycm_key_list_select_completion = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" ultisnip config
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_quiet_messages = { 'regex': 'E501\|E501' }

" import local .vimrc
if filereadable($HOME . "/.vimrc_local")
 source $HOME/.vimrc_local
endif
