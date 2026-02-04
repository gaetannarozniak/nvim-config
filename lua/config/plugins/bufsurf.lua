return {
  "ton/vim-bufsurf",
  config = function ()
    vim.keymap.set("n", "<C-h>", ":BufSurfBack<CR>")
    vim.keymap.set("n", "<C-l>", ":BufSurfForward<CR>")
  end,
}
