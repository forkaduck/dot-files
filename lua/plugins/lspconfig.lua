function lspconfig_init()
    -- setup the language servers with the help of lspconfig.
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Disable snippets from LSP.
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    local on_attach = function(client)
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false})")
        end

        for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
            local default_diagnostic_handler = vim.lsp.handlers[method]
            vim.lsp.handlers[method] = function(err, result, context, config)
                if err ~= nil and err.code == -32802 then
                    return
                end
                return default_diagnostic_handler(err, result, context, config)
            end
        end
    end

    require("lspconfig").rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                },
                -- Add clippy lints for Rust.
                checkOnSave = true,
                check = {
                    allFeatures = true,
                    command = "clippy",
                    extraArgs = {
                        "--",
                        "--no-deps",
                        "-Dclippy::correctness",
                        "-Dclippy::complexity",
                        "-Wclippy::perf",
                        "-Wclippy::pedantic",
                    },
                },
                procMacro = {
                    enable = true,
                },
            },
        },
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

    require('lspconfig').pylsp.setup ({
        capabilities = capabilities,
        on_attach = on_attach,
    })

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
