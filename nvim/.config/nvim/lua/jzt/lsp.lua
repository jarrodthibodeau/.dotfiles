local lsp = require("lsp-zero")
local mason = require("mason")
local masonLspConfig = require("mason-lspconfig")

lsp.preset("recommend");

mason.setup({})
masonLspConfig.setup({
    ensure_installed = {
        'lua_ls',
        'tsserver'
    },
    handlers = {
        lsp.default_setup
    }
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['tsserver'] = { 'javascript', 'typescript', 'typescriptreact' },
        ['lua_ls'] = { 'lua' }
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
