
function cmp_init()
    -- Setup nvim-cmp.
    local cmp = require("cmp")

    local cmp_kinds = {
        Text = "󰉿",
        Type = "⇅",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        VariableBuiltin = "β",
        VariableMember = "γ",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        KeywordFunction = "󰌋",
        KeywordType = "󰌋",
        KeywordRepeat = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
        Codeium = "🧠",
        Supermaven = "⚡🧠",
    }

    global_mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        })


    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        mapping = global_mapping,

        sources = cmp.config.sources({
            {
                name = "nvim_lsp_signature_help",
                priority = 4
            },
            {
                name = "nvim_lsp",
                priority = 4
            },
            {
                name = "nvim_lua",
                priority = 4
            },
            {
                name = "path",
                priority = 3
            },
            {
                name = "codeium",
                priority = 3
            },
            --  {
                --  name = "treesitter",
                --  priority = 3
            --  },
            {
                name = "luasnip",
                priority = 2
            },
            {
                name = "buffer",
                priority = 1
            }
        }),
        formatting = {
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format("%s %s", cmp_kinds[vim_item.kind], vim_item.kind)
                vim_item.menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[LaTeX]",
                })[entry.source.name]
                return vim_item
            end,
        },
        completion = {
            keyword_length = 1,
        },
        view = {
            entries = {name = 'custom', selection_order = 'near_cursor' }
        },
        experimental = {
            ghost_text = false,
        },
        enabled = function()
            -- disable completion in comments
            local context = require 'cmp.config.context'
            -- keep command mode completion enabled when cursor is in a comment
            if vim.api.nvim_get_mode().mode == 'c' then
                return true
            else
                return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
            end
        end,
    })

    -- not working because of native menu
    -- Use buffer source for `/`.
    cmp.setup.cmdline("/", {
        sources = {
            { name = 'nvim_lsp' },
            { name = 'buffer' },
        },
        mapping = global_mapping,
    })

    -- Use cmdline & path source for ':'.
    cmp.setup.cmdline(":", {
        sources = {
            { name = 'cmdline' },
            { name = 'path' },
        },
        mapping = global_mapping,
    })

    vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
        float = {
            source = "always",
        }
    })
end

return {
	-- Completion plugin
    {
        "hrsh7th/nvim-cmp",
        config = cmp_init,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "ray-x/cmp-treesitter",
            "saadparwaiz1/cmp_luasnip"
        },
    },
}
