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
setup_lsp(
    "jdtls",
    {
        cmd = { 'jdtls' },
        root_dir = function() return vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'pom.xml', 'mvnw'}, { upward = true })[1]) end,
        settings = {
            java = {
                signatureHelp = { enabled = true },
                -- contentProvider = { preferred = 'fernflower' },  -- Use fernflower to decompile library code
                -- Specify any completion options
                completion = {
                    -- favoriteStaticMembers = {
                    --     "org.hamcrest.MatcherAssert.assertThat",
                    --     "org.hamcrest.Matchers.*",
                    --     "org.hamcrest.CoreMatchers.*",
                    --     "org.junit.jupiter.api.Assertions.*",
                    --     "java.util.Objects.requireNonNull",
                    --     "java.util.Objects.requireNonNullElse",
                    --     "org.mockito.Mockito.*"
                    -- },
                    -- filteredTypes = {
                    --     "com.sun.*",
                    --     "io.micrometer.shaded.*",
                    --     "java.awt.*",
                    --     "jdk.*", "sun.*",
                    -- },
                },
                -- Specify any options for organizing imports
                sources = {
                    organizeImports = {
                        starThreshold = 9999;
                        staticStarThreshold = 9999;
                    },
                },
                -- How code generation should act
                codeGeneration = {
                    hashCodeEquals = {
                        useJava7Objects = true,
                    },
                    useBlocks = true,
                },
                -- If you are developing in projects with different Java versions, you need
                -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
                -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                -- And search for `interface RuntimeOption`
                -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
                -- configuration = {
                --     runtimes = {
                --         {
                --             name = "JavaSE-19",
                --             path = "/usr/lib/jvm/java-19-openjdk-amd64"
                --         },
                --     }
                -- }
            }
        },
    }
)
