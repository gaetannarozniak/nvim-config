return {
  "ggandor/leap.nvim",
  config = function()
    vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
    vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')
    -- OR if you prefer: require("leap").set_default_keymaps()
    require("leap").opts = {
      -- your options here
    }
  end,
}
