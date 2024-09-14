return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set('n', 'K', function()
                    vim.lsp.buf.hover()
                end, opts)
                vim.keymap.set('n', 'gd', function()
                    vim.lsp.buf.definition()
                end, opts)
                vim.keymap.set('n', 'gD', function()
                    vim.lsp.buf.declaration()
                end, opts)
                vim.keymap.set('n', 'gi', function()
                    vim.lsp.buf.implementation()
                end, opts)
                vim.keymap.set('n', 'go', function()
                    vim.lsp.buf.type_definition()
                end, opts)
                vim.keymap.set('n', 'gs', function()
                    vim.lsp.buf.signature_help()
                end, opts)
                vim.keymap.set('n', '<leader>rn', function()
                    vim.lsp.buf.rename()
                end, opts)
                vim.keymap.set('n', '<leader>ca', function()
                    vim.lsp.buf.code_action()
                end, opts)
            end,
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        require('mason').setup()
        require('mason-lspconfig').setup {
            ensure_installed = { 'lua_ls' },
        }

        require('mason-lspconfig').setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup { capabilities = capabilities }
            end,
            ['lua_ls'] = function()
                require('lspconfig').lua_ls.setup {
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            runtime = {
                                version = 'LuaJIT',
                            },
                            diagnostics = {
                                globals = { 'vim' },
                            },
                            workspace = {
                                library = {
                                    vim.env.VIMRUNTIME,
                                },
                            },
                        },
                    },
                }
            end,
        }
    end,
}
