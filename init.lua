require("config.lazy")

vim.opt.wrap = false
vim.opt.shiftwidth = 4
-- vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "∆", "<cmd>cnext<CR>")
vim.keymap.set("n", "<˚>", "<cmd>cprev<CR>")

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<Tab>", ":bprev<CR>")
vim.keymap.set("n", "<S-Tab>", ":bnext<CR>")
vim.keymap.set("n", "<leader>cp", ":let @+ = expand('%:p')<CR>")

vim.keymap.set("n", "H", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "L", "<C-w>l", { desc = "Go to right window" })

vim.lsp.enable('lua_ls')

vim.keymap.set("n", "<leader>pdb", "Oimport ipdb; ipdb.set_trace()<Esc>", {
  desc = "Insert pdb breakpoint above (respect indentation)",
})


--[[ vim.keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end) ]]

vim.keymap.set("n", "<space>st", function()
  local file_dir = vim.fn.expand("%:p:h")

  vim.cmd.vnew()
  vim.fn.termopen(vim.o.shell, { cwd = file_dir })
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end)

vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set("n", "-", "<cmd>Oil<CR>")
require("dap-python").setup("/storage/home/gaetan/.virtualenvs/debugpy/bin/python")

vim.o.splitright = true

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>")
vim.keymap.set("n", "gs", "<cmd>Telescope lsp_document_symbols<CR>")
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)

vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")

vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "<leader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
vim.keymap.set("v", "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "evaluate visual selection" })
vim.keymap.set("n", "<leader>dt", ":MoltenDelete<CR>", { silent = true, desc = "molten delete cell" })
vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>", { silent = true, desc = "hide output" })
vim.keymap.set("n", "<leader>os", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "show/enter output" })

vim.keymap.set('v', '<D-c>', '"+y')
