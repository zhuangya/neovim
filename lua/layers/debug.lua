-- debug.lua

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  keys = {
    -- normal mode is default
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "[DAP] Break",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "[DAP] Continue(Start)",
    },
    {
      "<leader>dn",
      function()
        require("dap").step_over()
      end,
      desc = "[DAP] Step Over",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "[DAP] Step Into",
    },
    {
      "<leader>do",
      function()
        require("dap").step_out()
      end,
      desc = "[DAP] Step Out",
    },
    {
      "<leader>de",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "[DAP] Break Condition",
    },
  },
  config = function()
    require("dapui").setup()
    local dap, dapui = require("dap"), require("dapui")

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
        args = { "${port}" },
      },
    }

    dap.configurations.typescript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        runtimeExecutable = "deno",
        runtimeArgs = {
          "run",
          "--inspect-wait",
          "--allow-all",
        },
        program = "${file}",
        cwd = "${workspaceFolder}",
        attachSimplePort = 9229,
      },
    }

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({ reset = true })
    end
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end,
}

-- return {
--   "mfussenegger/nvim-dap",
--   dependencies = {
--     "nvim-neotest/nvim-nio",
--     "rcarriga/nvim-dap-ui",
--     "williamboman/mason.nvim",
--     "jay-babu/mason-nvim-dap.nvim",
--     -- Add your own debuggers here
--     "mxsdev/nvim-dap-vscode-js",
--   },
--   config = function()
--     local dap = require("dap")
--     local dapui = require("dapui")
--
--     require("mason-nvim-dap").setup({
--       -- Makes a best effort to setup the various debuggers with
--       -- reasonable debug configurations
--       automatic_setup = true,
--
--       -- You can provide additional configuration to the handlers,
--       -- see mason-nvim-dap README for more information
--       handlers = {},
--
--       -- You'll need to check that you have the required things installed
--       -- online, please don't ask me how to install them :)
--       ensure_installed = {
--         "js-debug-adapter",
--         -- Update this to ensure that you have the debuggers for the langs you want
--         -- "delve",
--       },
--     })
--
--     -- Basic debugging keymaps, feel free to change to your liking!
--     vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
--     vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
--     vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Debug: Step Over" })
--     vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug: Step Out" })
--     vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
--     vim.keymap.set("n", "<leader>de", function()
--       dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
--     end, { desc = "Debug: Set Breakpoint" })
--
--     -- Dap UI setup
--     -- For more information, see |:help nvim-dap-ui|
--     dapui.setup({
--       -- Set icons to characters that are more likely to work in every terminal.
--       --    Feel free to remove or use ones that you like more! :)
--       --    Don't feel like these are good choices.
--       icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
--       controls = {
--         icons = {
--           pause = "⏸",
--           play = "▶",
--           step_into = "⏎",
--           step_over = "⏭",
--           step_out = "⏮",
--           step_back = "b",
--           run_last = "▶▶",
--           terminate = "⏹",
--           disconnect = "⏏",
--         },
--       },
--     })
--
--     -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
--     vim.keymap.set("n", "<leader>dr", dapui.toggle, { desc = "Debug: See last session result." })
--
--     dap.listeners.after.event_initialized["dapui_config"] = dapui.open
--     dap.listeners.before.event_terminated["dapui_config"] = dapui.close
--     dap.listeners.before.event_exited["dapui_config"] = dapui.close
--
--     dap.configurations["typescript"] = {
--       {
--         type = "pwa-node",
--         request = "launch",
--         name = "Launch file",
--         program = "${file}",
--         cwd = "${workspaceFolder}",
--       },
--     }
--
--     -- Install golang specific config
--     -- require("dap-go").setup()
--     require("dap-vscode-js").setup({
--       adapters = { "pwa-node", "pwa-chrome", "node-terminal" },
--     })
--   end,
-- }
