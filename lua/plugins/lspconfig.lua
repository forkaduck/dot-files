function lspconfig_init()
    -- setup the language servers with the help of lspconfig.
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Disable snippets from LSP.
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    local on_attach = function(client)
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false})")
        end
    end

    require("lspconfig").rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                    enable = true
                },
                experimental = {
                    enable = true
                },
            },
            inlayHints = {
                parameterHints = {
                    enable = true
                }
            },
        }
    })

    require("lspconfig").asm_lsp.setup({
        filetypes = {"asm", "vmasm", "nasm"},
        capabilities = capabilities,
        on_attach = on_attach,
    })
     

    require("lspconfig").pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })

    require("lspconfig").clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })

    --  require("lspconfig").cmake.setup({
        --  capabilities = capabilities,
        --  on_attach = on_attach,
    --  })

    require('lspconfig').pylsp.setup ({
        capabilities = capabilities,
        on_attach = on_attach,
    })

    --  require('lspconfig').
    -- --- Custom language servers ---
    -- require("null-ls").setup({
        -- capabilities = capabilities,
        -- sources = {
            -- require("null-ls").builtins.diagnostics.flake8,
            -- -- require("null_ls").builtins.diagnostics.proselint,
            -- require("null-ls").builtins.formatting.stylua,
            -- require("null-ls").builtins.formatting.black,

            -- require("null-ls").builtins.diagnostics.shellcheck,
            -- require("null-ls").builtins.code_actions.shellcheck,
        -- },
        -- -- debug = true,
        -- debounce = 200,
        -- default_timeout = 5000,
        -- diagnostics_format = "[#{c}] #{m} (#{s})",
    -- })

    require("lspconfig").veridian.setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })

    require("lspconfig").jdtls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end


return {
    -- Common lsp configs
    {
        "neovim/nvim-lspconfig",
        config = lspconfig_init
    },
}
