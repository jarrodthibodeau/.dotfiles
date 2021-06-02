" Automatic installation of vim-plug which is a plugin that installs plugins
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged/'
" Starts the process of installing plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript' " JS support
Plug 'leafgarland/typescript-vim' " TS syntax
Plug 'maxmellon/vim-jsx-pretty' " JS and JSX syntax
Plug 'jparise/vim-graphql' " GQL syntax
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat',
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc-eslint'
Plug 'vim-airline/vim-airline'
call plug#end()

" Enable syntax highlighting
:syntax enable

" Set scrolling offset to 8 lines 
set scrolloff=8

" Add numbers to the lines
:set number

" Spacing settings
:set tabstop=4
:set softtabstop=4
:set shiftwidth=4
:set expandtab
:set smartindent

" Setting true colors to be enabled
set termguicolors
" Setting the color scheme of the editor
:colorscheme gruvbox
set background=dark

" Setting leader to space
let mapleader = " "

"silent means nothing, leader means whatever mapleader is"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" CoC GoTo Navigation mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" n - normal mode
" nore - no recursive execution
" map - map A -> B
" This maps the leader <space> pv to execute the vertical explore command
nnoremap <leader>pv :Vex<CR>

" <space><enter> will resrouce the vimrc to accept new changes
nnoremap <leader><CR> :so ~/.dotfiles/vimrc<CR>

" Set Ctrp-P to Fuzzy find all source control files
nnoremap <C-p> :GFiles<CR>

" Fuzzy find all project files via <space><p><f>
nnoremap <leader>pf :Files<CR>

" Open up git status via vim fugitive
nmap <leader>gs :G<CR>
