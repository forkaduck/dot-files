function lualine_init()
    local function dap_status()
        local dap = require('dap')

        return dap.status()
    end

    require("lualine").setup({
        options = {
            theme = "onedark",
            component_separators = { left = '|', right = '|'},
            section_separators = { left = '', right = ''},
        },
        sections = {
            lualine_a = {
                "mode",
            },
            lualine_b = {
                "diff",
                "branch",
            },
            lualine_c = {
                "filename",
                "encoding",
            },
            lualine_x = {
                dap_status,
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    -- displays diagnostics from defined severity
                    sections = { "error", "warn", "info", "hint" },
                    -- all colors are in format #rrggbb
                    color_error = "#8f2b2b", -- changes diagnostic's error foreground color
                    color_warn = "#6b6e01", -- changes diagnostic's warn foreground color
                    color_info = "#00ada2", -- Changes diagnostic's info foreground color
                    color_hint = "#00ad3b", -- Changes diagnostic's hint foreground color
                    symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                },
                lsp_progress,
            },
            lualine_y = {
                "filetype",
            },
            lualine_z = {
                "progress",
                "location",
                "filesize",
                "fileformat",
            },
        },
    })
end


return {
	-- Status line
	{
        "nvim-lualine/lualine.nvim",
        opts = {},
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = lualine_init
    },
}
