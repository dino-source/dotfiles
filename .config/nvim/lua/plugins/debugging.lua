return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("dapui").setup()

        dap.adapters.cpp = {
            type = "executable",
            command = "/usr/bin/lldb-vscode",
            env = {
                LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
            },
            name = "lldb",
        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "cpp",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}/build/src/app",
                args = {},
            },
        }

        dap.configurations.c = dap.configurations.cpp

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end

        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end

        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end

        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<F5>", dap.continue, {})
        vim.keymap.set("n", "<F10>", dap.step_over, {})
        vim.keymap.set("n", "<F11>", dap.step_into, {})
        vim.keymap.set("n", "<F12>", dap.step_out, {})
        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<leader>B", dap.set_breakpoint, {})
    end,
}
