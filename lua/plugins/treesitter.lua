function treesitter_init()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "c",
            "rust",
            "c_sharp",
            "java",
            "kotlin",

            "verilog",

            "lua",
            "make",
            "ninja",
            "python",
            "vim",
            "yaml",
            "scala",

            "regex",
            "latex",

            "json",
            "json5",
            "toml",
            "html",
            "javascript",
            "typescript",
            "markdown",
        },
        sync_install = false,
        auto_install = true,

        highlight = {
            enable = true, -- false will disable the whole extension
            additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gn", -- set to `false` to disable one of the mappings
                node_incremental = false,
                scope_incremental = false,
                node_decremental = false,
            },
        },
        indent = {
            enable = true,
        },
        matchup = {
            enable = true,
        },

        markid = {
            enable = true,
        },
    })
end

return {
	-- Treesitter plugin
	{
		"nvim-treesitter/nvim-treesitter",
        config = treesitter_init,
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-context',
                opts = {
                    max_lines = 10,
                    multiline_threshold = 10,
                    trim_scope = 'outer'
                }
            }
        },
        --  build = function()
            --  vim.cmd(":TSUpdate")
        --  end,
	},
}
