-- --- disable default plugins ---
local disabled_built_ins = {
	"netrwSettings",
	"netrw",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
    "python3_provider",
    "ruby_provider",
    "node_provider",
    "perl_provider"
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- --- General settings ---
-- Enable line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

if not vim.g.vscode then
    -- Spellcheck.
    vim.opt.spell = true
    vim.opt.spelllang = "en,de"
end

-- Fix end of line.
vim.opt.fixeol = false

-- Disables redraw on some events.
vim.opt.lazyredraw = true

-- Automatically load changed files.
vim.opt.autoread = true

-- Show filename in title.
vim.opt.title = true

-- Let vim open up to 100 tabs at once.
vim.opt.tabpagemax = 100

-- Case-insensitive filename completion.
vim.opt.wildignorecase = true

-- Modify completion window.
vim.opt.completeopt = {'menuone', 'noinsert', 'popup', 'preview'}

-- Make sign gutter autosize with two rows
vim.opt.signcolumn = "yes:2"

-- Automatically read file changes
vim.opt.autoread = true

-- Split vertical windows right to the current window
vim.opt.splitright = true

-- Split horizontal windows below the current window
vim.opt.splitbelow = true

-- Set keycombo timeout to 250ms
vim.opt.timeoutlen = 300

-- enable true color
vim.opt.termguicolors = true

-- Set default file encoding to utf8
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Set the minimum distance between cursor and vertical screen bounds.
vim.opt.scrolloff=20

-- --- Searching ---
-- When there is a previous search pattern, highlight all its matches
vim.opt.hlsearch = true

-- Enable live replacement when using substitude
vim.opt.inccommand = "nosplit"

-- While typing a search command, show immediately where the so far typed pattern matches
vim.opt.incsearch = true

-- Don't ignore case in search patterns
vim.opt.ignorecase = false

-- Override the 'ignorecase' option if the search pattern contains uppercase characters
vim.opt.smartcase = true

-- Search from top when at bottom
vim.opt.wrapscan = true

-- Enable softwrapping
vim.opt.wrap = true

-- --- Indenting ---
-- styling options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- When auto-indenting, use the indenting format of the previous line
vim.opt.copyindent = false

-- When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
-- 'tabstop' is used in other places. A <BS> will delete a 'shiftwidth' worth of
-- space at the start of the line.
vim.opt.smarttab = true

-- Copy indent from current line when starting a new line (typing <CR> in Insert
-- mode or when using the "o" or "O" command)
vim.opt.autoindent = true

-- Automatically inserts one extra level of indentation in some cases, and works
-- for C-like files
vim.opt.smartindent = false

-- Swap file write delay
vim.o.updatetime = 1000

-- --- Temp files ---
-- Set the temporary file directories to something more usable.
vim.opt.backupdir = vim.fn.expand("$HOME/.local/share/nvim/backup//")
vim.opt.directory = vim.fn.expand("$HOME/.local/share/nvim/swap//")
vim.opt.undodir = vim.fn.expand("$HOME/.local/share/nvim/undo//")
vim.opt.undofile = true

-- Remap the leader to ;
vim.g.mapleader = ';'

-- A few session options from auto-session.
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Enable Wrapping
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.list = false

-- Add characters as word boundaries
vim.opt.iskeyword:remove("_")
vim.opt.iskeyword:remove("-")

if not vim.g.vscode then
    require("config.lazy")
end

-- --- Key remapping ---
-- Tabswitching
vim.keymap.set("n", "<c-h>", "<cmd>BufferPrevious<CR>", {})
vim.keymap.set('n', '<c-l>', '<cmd>BufferNext<CR>', {})

-- Tab-move
vim.keymap.set("n", ">", "<cmd>BufferMoveNext<CR>", {})
vim.keymap.set("n", "<", "<cmd>BufferMovePrevious<CR>", {})

if not vim.g.vscode then
    -- Jump to code diagnostics
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, {})
    vim.keymap.set("n", "gd", function() require("telescope.builtin").lsp_definitions{} end, {})
    vim.keymap.set("n", "gi", function() require("telescope.builtin").lsp_implementations{} end, {})
    vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references{} end, {})

    -- Debugging
    vim.keymap.set("n", "db", function() require('dap').toggle_breakpoint() end, {})
    vim.keymap.set("n", "dc", function() require('dap').continue() end, {})
    vim.keymap.set("n", "dr", function() require('dap').repl.open({}, 'vsplit') end, {})
    vim.keymap.set("n", "<Up>", function() require('dap').step_back() end, {})
    vim.keymap.set("n", "<Down>", function() require('dap').step_over() end, {})
    vim.keymap.set("n", "<Right>", function() require('dap').step_into() end, {})
    vim.keymap.set("n", "<Left>", function() require('dap').step_out() end, {})

    -- Hover show
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, {})

    -- Misc.
    vim.keymap.set("n", "<leader>s", function() require("telescope.builtin").spell_suggest{} end, {})
    vim.keymap.set("n", "<leader>f", function() require("telescope.builtin").live_grep{} end, {})
    vim.keymap.set("n", "<leader>n", '<cmd>NnnPicker<CR>', {})
    vim.keymap.set("n", "<leader>ut", "<cmd>UndotreeShow<CR>", {})
    vim.keymap.set("n", "<leader>th", function() toggle_inlay_hint() end, {})
    vim.keymap.set("n", "<leader>w", function() require("supermaven-nvim.api").toggle() end, {})

    -- Harpoon
    local harpoon = require("harpoon")
    vim.keymap.set("n", "<leader>t", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {})
    vim.keymap.set("n", "<leader>m", function() harpoon:list():add() end, {})

    -- Lsp actions.
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, {})
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, {})

    vim.keymap.set("i", "<leader><Tab>", function() require("neocodeium").accept() end, {noremap = true, silent = true})

    -- Toggles inlay hints, (function argument names, types, usw).
    function toggle_inlay_hint()
        if vim.lsp.inlay_hint.is_enabled() then
            vim.lsp.inlay_hint.enable(false, { bufnr })
        else
            vim.lsp.inlay_hint.enable(true, { bufnr })
        end
    end

    -- Autocommands
    -- On hover floating window.
    vim.api.nvim_create_augroup('bufcheck', { clear = true })

    vim.api.nvim_create_autocmd('CursorHold', {
        group = "bufcheck",
        pattern = '*',
        callback = function()
            vim.diagnostic.open_float(0, {scope="line", focusable=false})
        end,
    })

    -- Overwrite some filetypes to make syntax highlighting work. (Mostly)
    vim.api.nvim_create_augroup('filetypeoverwrite', { clear = true })

    vim.api.nvim_create_autocmd({'BufNewFile', 'BufReadPost'}, {
        group = "filetypeoverwrite",
        pattern = "*.cl",
        callback = function ()
            vim.cmd('set filetype=c', {})
        end,
    })
else
    vim.keymap.set("n", "<c-h>", function() require('vscode').action('workbench.action.previousEditor') end, {})
    vim.keymap.set("n", "<c-l>", function() require('vscode').action('workbench.action.nextEditor') end, {})

    vim.keymap.set("n", "<leader>s", function() require('vscode').action('workbench.action.quickOpen') end, {})
    vim.keymap.set("n", "<leader>f", function() require('vscode').action('workbench.action.findInFiles') end, {})
    vim.keymap.set("n", "<leader>c", function() require('vscode').action('editor.action.quickFix') end, {})
    vim.keymap.set("n", "<leader>r", function() require('vscode').action('editor.action.rename') end, {})
    vim.keymap.set("n", "<leader><space>", function() require('vscode').action('editor.action.blockComment') end, {})


    -- Jump to Declaration
    vim.keymap.set("n", "gD", function() require('vscode').action('editor.action.revealDeclaration') end, {})
    vim.keymap.set("n", "gd", function() require('vscode').action('editor.action.revealDefinition') end, {})
    vim.keymap.set("n", "gi", function() require('vscode').action('editor.action.goToImplementation') end, {})
    vim.keymap.set("n", "gr", function() require('vscode').action('editor.action.goToReferences') end, {})

    -- Debugging
    vim.keymap.set("n", "db", function() require('vscode').action('editor.debug.action.toggleBreakpoint') end, {})
    vim.keymap.set("n", "dc", function() require('vscode').action('workbench.action.debug.continue') end, {})
end
