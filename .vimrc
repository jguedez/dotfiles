set nocompatible               " be iMproved
filetype off                   " required!

" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Bundle 'gmarik/vundle'

    " Core plugins
    Bundle 'tpope/vim-sensible'
    Bundle 'majutsushi/tagbar'
    Bundle 'christoomey/vim-tmux-navigator'
    Bundle 'mattn/emmet-vim'
    Bundle 'tomtom/tcomment_vim'
    Bundle 'scrooloose/nerdtree'
    Bundle 'ervandew/supertab'
    Bundle 'tomtom/tlib_vim'
    Bundle 'jgdavey/tslime.vim'
    Bundle 'MarcWeber/vim-addon-mw-utils'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'tpope/vim-surround'
    Bundle 'kien/ctrlp.vim'
    Bundle 'tomasr/molokai'

    " Snippets plugins
    Bundle 'garbas/vim-snipmate'
    Bundle 'honza/vim-snippets'

    " Syntax plugins
    Bundle 'scrooloose/syntastic'
    Bundle 'klen/python-mode'
    Bundle 'davidhalter/jedi-vim'
    Bundle 'kchmck/vim-coffee-script'
    Bundle 'digitaltoad/vim-jade'
    Bundle 'guns/vim-clojure-static'
    Bundle 'hylang/vim-hy'
    Bundle 'derekwyatt/vim-scala'
    Bundle 'chrisbra/csv.vim'

    " Git plugins
    Bundle 'tpope/vim-fugitive'
    Bundle 'mhinz/vim-signify'

    " Github repos of the user 'vim-scripts'
    " => can omit the username part
    " Bundle 'L9'
    " Bundle 'FuzzyFinder'

    " non github repos
    "Bundle 'git://git.wincent.com/command-t.git'
    "...All your other bundles...
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" Setting up Vundle - the vim plugin bundler end

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

map <left> <nop>
map <right> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
noremap <left> gT
noremap <right> gt
noremap <up> :tabnew <CR>
noremap <down> :bd <CR>

let @d='0Oimport ipdb; ipdb.set_trace()0'

set wildchar=<Tab> wildmenu wildmode=full

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
vnoremap <F5> "ry :call Send_to_Tmux(@r)<CR>
nnoremap <F5> V "ry :call Send_to_Tmux(@r)<CR>
nnoremap <S-F5> <Plug>SetTmuxVars
"
" helpers for clipboard/copy/paste
set pastetoggle=<F2>
set clipboard=unnamed

" trigger tagbar
noremap <silent> <F3> :TagbarToggle<CR>

" enable python-mode
let g:pymode_run = 1
let g:pymode_rope = 0
let g:pymode_lint = 0
let g:pymode_virtualenv = 1
let g:pymode_motion = 1
let g:pymode_folding = 1

" supertab
let g:SuperTabDefaultCompletionType = "context"

" emmet just for html/css
let g:user_emmet_install_global = 0
augroup plugin_emmet
    autocmd!
    autocmd FileType html,css,htmldjango EmmetInstall
augroup END

" ctrlp - extensions excludes
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

" filetype overrides
augroup filetype_custom
    autocmd!
    autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType jade setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType coffee setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType hy setlocal shiftwidth=2 tabstop=2 softtabstop=2
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

" import local .vimrc
if filereadable($HOME . "/.vimrc_local")
 source $HOME/.vimrc_local
endif
