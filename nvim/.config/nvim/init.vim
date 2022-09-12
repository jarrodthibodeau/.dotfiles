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
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript' " JS support
Plug 'leafgarland/typescript-vim' " TS syntax
Plug 'maxmellon/vim-jsx-pretty' " JS and JSX syntax
Plug 'jparise/vim-graphql' " GQL syntax
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'jose-elias-alvarez/null-ls.nvim' " LSP specific stuff for diagnostics, formatting etc

Plug 'hrsh7th/nvim-cmp' " This and next three are for LSP autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Treesitter bby
call plug#end()

lua require("jzt")
"
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

" neovim-lsp navigation mappings
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.declaration()<CR>

" neovim-lsp diagnostic mappings 
nnoremap <silent> <leader>e :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> [d :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d :lua vim.lsp.diagnostic.goto_next()<CR>

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
