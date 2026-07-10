return {
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "master",          -- pin to stable branch
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({   -- note: .configs
          ensure_installed = {
            "c", "lua", "vim", "python",
            "vimdoc", "query", "markdown", "markdown_inline",
          },
          highlight = {
            enable = true,        -- ← this auto-enables highlighting
            -- master-native way to skip huge files:
            disable = function(_, buf)
              local max = 500 * 1024 -- 500 KB
              local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
              return ok and stats and stats.size > max
            end,
          },
          indent = { enable = true },
        })
      end,
    },
  }
