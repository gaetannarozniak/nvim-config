vim.wo.number = true

-- Store the terminal buffer number globally
local python_term_buf = nil

-- Function to open a persistent Python REPL
local function open_python_repl()
  if python_term_buf and vim.api.nvim_buf_is_valid(python_term_buf) then
    vim.api.nvim_set_current_buf(python_term_buf)
  else
    vim.cmd('belowright split | terminal python3')
    python_term_buf = vim.api.nvim_get_current_buf()
  end
end

-- Function to send code to the Python REPL
local function send_to_python(code)
  open_python_repl()
  -- Send each line of code with a newline
  for line in code:gmatch("[^\r\n]+") do
    vim.fn.chansend(vim.b.terminal_job_id, line .. "\n")
  end
end

-- Run current Python file
local function run_python_file()
  vim.cmd('write')
  local filename = vim.fn.expand('%')
  send_to_python("exec(open('" .. filename .. "').read())")
end

-- Run current line
local function run_current_line()
  local line = vim.fn.getline('.')
  send_to_python(line)
end

-- Run visual selection
local function run_visual_selection()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.fn.getline(start_line, end_line)
  local code = table.concat(lines, "\n")
  send_to_python(code)
end

-- Keymaps
vim.keymap.set('n', '<space><space>x', run_python_file, { noremap = true, silent = true, desc = 'Run Python file' })
vim.keymap.set('n', '<space>x', run_current_line, { noremap = true, silent = true, desc = 'Run current line of Python code' })
vim.keymap.set('v', '<space>x', run_visual_selection, { noremap = true, silent = true, desc = 'Run selected lines of Python code' })
