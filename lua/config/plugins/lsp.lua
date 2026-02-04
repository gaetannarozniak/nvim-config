return {
  {
    vim.diagnostic.config({
      virtual_text = {
	prefix = "",  -- you can choose a prefix or icon
	spacing = 2,
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
  },
  {
    "neovim/nvim-lspconfig",
    vim.lsp.config('lua_ls', {
      on_init = function(client)
	client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
	  runtime = {
	    -- Tell the language server which version of Lua you're using (most
	    -- likely LuaJIT in the case of Neovim)
	    version = 'LuaJIT',
	    -- Tell the language server how to find Lua modules same way as Neovim
	    -- (see `:h lua-module-load`)
	    path = {
	      'lua/?.lua',
	      'lua/?/init.lua',
	    },
	  },
	  -- Make the server aware of Neovim runtime files
	  workspace = {
	    checkThirdParty = false,
	    library = {
	      vim.env.VIMRUNTIME
	    }
	    }
	  })
	end,
	settings = {
	  Lua = {}
	}
      }),
      vim.lsp.enable('pyright')
    }
  }
