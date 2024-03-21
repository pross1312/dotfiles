if vim.fn.is_module_available('lsp-zero') then
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    client.server_capabilities.semanticTokensProvider = nil
    vim.diagnostic.disable(bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
    local opts = {buffer = bufnr, remap = true}

    vim.keymap.set("n", "<leader>fr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('i', '<M-i>', vim.lsp.buf.hover, opts)
end)
lsp_zero.set_sign_icons({
    error = '',
    warn = '',
    hint = '',
    info = '',
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        lsp_zero.default_setup,
    },
})
local lsp = require('lspconfig')
local function setup_lsp(server, opts)
    local conf = lsp[server]
    if not conf then return end
    conf.setup(opts)
    local try_add = conf.manager.try_add
    conf.manager.try_add = function (bufnr)
        if not vim.b.large_buf then
            return try_add(bufnr)
        end
    end
end

setup_lsp(
    "tsserver",
    { on_attach = on_attach, root_dir = lsp.util.root_pattern({"package.json", ".git"}), capabilities = capabilities }
)
vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
setup_lsp(
    "jdtls",
    {
        cmd = { 'jdtls' },
        root_dir = lsp.util.root_pattern({"pom.xml", ".git"}),
    }
)
end
