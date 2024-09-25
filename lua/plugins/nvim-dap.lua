function dap_init()
    local dap = require('dap')

    dap.adapters.python = {
        type = 'executable';
        command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
        args = { '-m', 'debugpy.adapter' };
    }

    dap.defaults.fallback.external_terminal = {
        command = '/usr/bin/wezterm';
        args = {'-e'};
    }

    dap.adapters.lldb = function(cb, config)
        local port = (config.connect or config).port
        local host = (config.connect or config).host or '127.0.0.1'
        if config.external == true then
            return cb({
                type = 'server',
                port = 8888,
                host = host,
            })
        else
            return cb({
                type = 'server',
                port = "${port}",
                executable = {
                    command = '/home/daniel/bin/codelldb/extension/adapter/codelldb',
                    args = {"--port", "${port}"},
                }
            })
        end
    end

    dap_lldb_conf = {{
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable?: ', vim.fn.getcwd() .. '/target/debug/' .. string.match(vim.fn.getcwd(), "[^/]+$") , 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },{
        name = 'External codelldb instance on Port 8888',
        type = 'lldb',
        request = 'launch',
        external = true,
        program = function()
            return vim.fn.input('Path to executable?: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },{
        name = 'GDBServer Remote Attach',
        type = 'lldb',
        request = 'launch',
        targetCreateCommands = function()
            return {"target create " .. vim.fn.input('Path to executable?: ', vim.fn.getcwd() .. '/', 'file')}
        end,
        processCreateCommands = function()
            return {"gdb-remote " .. vim.fn.input('Debug Server Address?: ', '127.0.0.1:')}
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    }}

    dap.configurations.cpp = dap_lldb_conf
    dap.configurations.c = dap_lldb_conf
    dap.configurations.rust = dap_lldb_conf
end

return {
    -- Debug adapter
    {
        "mfussenegger/nvim-dap",
        config = dap_init
    }
}
