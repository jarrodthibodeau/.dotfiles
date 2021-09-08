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
Plug 'sbdchd/neoformat',
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'

Plug 'hrsh7th/nvim-cmp' " This and next two are for LSP autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
call plug#end()

lua require("jzt")

lua << EOF

local function on_attach()
    -- Only because The Primeagen has this really...
end

require'jzt'
require'lspconfig'.tsserver.setup{ on_attach=on_attach }


-- NVIM CMP

-- Config below can be found at https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- END NVIM-CMP
EOF


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

" neomvim-lsp diagnostic mappings 
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


"" NEOFORMAT
let g:neoformat_enabled_javascript = ['prettier-eslint', 'eslint_d', 'prettier']
let g:neoformat_enabled_typescript = ['prettier-eslint', 'eslint_d', 'prettier']

" Run Neoformat on save
augroup fmt
  autocmd!
  autocmd BufWrite * undojoin | Neoformat
augroup END
"" END NEOFORMAT
