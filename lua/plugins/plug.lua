return {
    --- Lua plugins ---
    -- Git Signs
	{
		"lewis6991/gitsigns.nvim",
        lazy = false,
        opts = {
            signs = {
                add          = { text = '+U' },
                change       = { text = '~U' },
                delete       = { text = '_', show_count = true },
                topdelete    = { text = '‾', show_count = true },
                changedelete = { text = '-U', show_count = true },
                untracked    = { text = '┆' },
            },
            signs_staged = {
                add = { text = '+S' },
                change = { text = '~S' },
                delete = { text = '_', show_count = true },
                topdelete = { text = '‾', show_count = true },
                changedelete = { text = '-S', show_count = true },
            },
            attach_to_untracked = true,
            signs_staged_enable = true,
        }
	},
    -- Theme
    {
      "loctvl842/monokai-pro.nvim",
      config = function()
          require("monokai-pro").setup({
                transparent_background = true,
            })

          vim.api.nvim_exec([[
              " --- Themeing ---
              " set theme
              " let g:sonokai_style = 'atlantis'
              " let g:sonokai_better_performance = 1
              " set background=dark
              " colorscheme sonokai

              colorscheme monokai-pro

              " set custom bracket highlighting
              hi MatchParen guibg=black gui=italic

              " Set highlighting color when searching and replacing one at a time
              hi incSearch guibg=red guifg=white gui=italic

              " gray
              hi CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
              " blue
              hi CmpItemAbbrMatch guibg=NONE guifg=#569CD6
              hi CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
              " light blue
              hi CmpItemKindVariable guibg=NONE guifg=#9CDCFE
              hi CmpItemKindInterface guibg=NONE guifg=#9CDCFE
              hi CmpItemKindText guibg=NONE guifg=#9CDCFE
              " pink
              hi CmpItemKindFunction guibg=NONE guifg=#C586C0
              hi CmpItemKindMethod guibg=NONE guifg=#C586C0
              " front
              hi CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
              hi CmpItemKindProperty guibg=NONE guifg=#D4D4D4
              hi CmpItemKindUnit guibg=NONE guifg=#D4D4D4

              hi Normal ctermbg=none guibg=none
              hi NormalNC ctermbg=none guibg=none
              hi NonText ctermbg=none guibg=none
              hi EndOfBuffer ctermbg=none guibg=none
          ]], true)

      end
    },

    -- Snipped plugin
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        build = "make install_jsregexp"
    },

	-- Nice list plugin
	{
        "nvim-telescope/telescope.nvim",
        opts = {},
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Undo tree
	{ "mbbill/undotree" },

	-- Commenter
	{ "winston0410/commented.nvim", opts = {} },


    -- Indent guides
	{
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end,
    },

    -- Tab-bar
    {
        "romgrk/barbar.nvim",
        opts = {
            tabpages = true,
            highlight_alternative = true,
            highlight_visible = true,
        }
    },

    -- Python debugging
    {
        "mfussenegger/nvim-dap-python",
        config = function ()
            require("dap-python").setup('~/.virtualenvs/debugpy/bin/python')
        end,
    },

    -- DAP Virtual text for variables and stuff.
    {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
            enabled = true,                        -- enable this plugin (the default)
            enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
            highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
            highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
            show_stop_reason = true,               -- show stop reason when stopped for exceptions
            commented = true,                     -- prefix virtual text with comment string
            only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
            all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
            clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
            --- A callback that determines how a variable is displayed or whether it should be omitted
            --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
            --- @param buf number
            --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
            --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
            --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
            --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
            display_callback = function(variable, buf, stackframe, node, options)
              if options.virt_text_pos == 'inline' then
                return ' = ' .. variable.value
              else
                return variable.name .. ' = ' .. variable.value
              end
            end,
            -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
            virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

            -- experimental features:
            all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
            virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
            virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                                                   -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
        }
    },

    -- ARGB/Hex Colors
    {
        "norcalli/nvim-colorizer.lua",
        opts = {},
    },

    -- LSP Status
    {
        "j-hui/fidget.nvim",
        opts = {
            notification = {
                window = {
                    winblend = 0,
                },
            },
        }
    },

    -- Session Plug-in.
    {
        'rmagatti/auto-session',
        opts = {
            log_level = "error",
            auto_save = true,
            auto_restore = true,
            auto_create = false,
        }
    },

    -- Displays Marks in gutter.
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {
              default_mappings = true,
        },
    },

    -- AI Coding Assistent
    {
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({
            })
        end
    },

    -- Remove lines at the end of files.
    {
        "mcauley-penney/tidy.nvim",
        config = true,
    },

    -- Number base conversion plugin.
    {
        "rr-/vim-hexdec"
    }
}
