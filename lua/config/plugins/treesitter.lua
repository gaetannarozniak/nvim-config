return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "python",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "lua", "c", "markdown", "vim", "query" },
	callback = function() vim.treesitter.start() end,
      })

      -- Disable treesitter for large files
      vim.api.nvim_create_autocmd("BufReadPre", {
        callback = function(args)
          local max_filesize = 500 * 1024 -- 500 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
          if ok and stats and stats.size > max_filesize then
            vim.treesitter.stop(args.buf)
          end
        end,
      })
    end,
  },
}
