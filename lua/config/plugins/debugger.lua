return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"
      local dap_python = require("dap-python")

      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()

      dap_python.setup("python3")

      vim.keymap.set("n", "<space>db", ":DapToggleBreakpoint<CR>")
      -- vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>")
      vim.keymap.set("n", "<leader>dr", ":DapRestartFrame<CR>")
      vim.keymap.set("n", "<leader>dq", ":DapTerminate<CR>")
      vim.keymap.set("n", "<leader>du", function() require("dapui").toggle() end, { desc = "DAP: Toggle UI" })
      -- vim.keymap.set("n", "<leader>du", dapui.toggle)
      --

      -- Function to set or del keymaps
      local function set_dap_keys()
	vim.keymap.set("n", "<Up>", ":DapStepOut<CR>", { desc = "Debug: Step Out" })
	vim.keymap.set("n", "<Down>", ":DapStepInto<CR>", { desc = "Debug: Step Into" })
	vim.keymap.set("n", "<Right>", ":DapStepOver<CR>", { desc = "Debug: Step Over" })
	vim.keymap.set("n", "<Left>", ":DapContinue<CR>", { desc = "Debug: Continue" })
      end

      local function del_dap_keys()
	-- Use pcall (protected call) to prevent errors if the keymap was already deleted
	pcall(vim.keymap.del, "n", "<Up>")
	pcall(vim.keymap.del, "n", "<Down>")
	pcall(vim.keymap.del, "n", "<Right>")
	pcall(vim.keymap.del, "n", "<Left>")
      end

      dap.listeners.after.event_initialized["dap_keymaps"] = function()
	set_dap_keys()
	ui.open() -- Moved inside the listener for consistency
      end

      dap.listeners.before.event_terminated["dap_keymaps"] = function()
	del_dap_keys()
	ui.close()
      end

      dap.listeners.before.event_exited["dap_keymaps"] = function()
	del_dap_keys()
	ui.close()
      end

      dap.configurations.python = {
	{
	  type = 'python',
	  request = 'attach',
	  name = 'Attach to Running Script',
	  subProcess = true,
	  justMyCode = false,
	  connect = {
	    port = 5678,
	    host = '127.0.0.1',
	  },
	  mode = 'remote',
	},
	-- for Ray
	{
	  type = 'python',
	  request = 'attach',
	  name = 'DAP: Ray Trainer Attach',
	  connect = {
	    port = 5678,
	    host = '127.0.0.1',
	  },
	  mode = 'remote',
	  -- This ensures Neovim maps the code in the worker to your local buffer
	  pathMappings = {
	    {
	      localRoot = vim.fn.getcwd(), 
	      remoteRoot = vim.fn.getcwd(),
	    },
	  },
	  justMyCode = false, -- Critical: VERL might be seen as "library code"
	}
      }

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
