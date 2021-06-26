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
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
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

lua require("jzt")

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
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" Set Ctrp-P to Fuzzy find all source control files
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>

" Fuzzy find all project files via <space><p><f>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

" Find instances based on text input
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>

" Open up git status via vim fugitive
nmap <leader>gs :G<CR>

" Adding ESC functionality to terminal mode in nvim
tnoremap <Esc> <C-\><C-N>