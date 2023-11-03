local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    client.server_capabilities.semanticTokensProvider = nil
    vim.diagnostic.disable(bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
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
require'lspconfig'.jdtls.setup{
    cmd = { 'jdtls' },
    root_dir = function() return vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]) end,
}
