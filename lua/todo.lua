local M = {}

-- Function to find TODOs in the current buffer and add them to diagnostics
M.add_todo_diagnostics = function()
  local diagnostics = {}
  local currentBuf = vim.api.nvim_get_current_buf()

  -- Iterate over each line in the buffer
  for lnum = 1, vim.fn.line('$') do
    local line = vim.fn.getline(lnum)

    -- Match lines with 'TODO'
    if string.match(line, 'TODO') then
      table.insert(diagnostics, {
        bufnr = currentBuf,
        lnum = lnum - 1,
        end_lnum = lnum - 1,
        col = 1,
        end_col = 1,
        severity = vim.diagnostic.severity.INFO,
        message = "TODO",
        source = 'TODO'
      })
    end
  end

  -- Set the diagnostics for the current buffer
  vim.diagnostic.set(vim.api.nvim_create_namespace("todo_namespace"), currentBuf, diagnostics, {})
end

vim.api.nvim_create_user_command('AddTodoDiagnostics', function()
  M.add_todo_diagnostics()
end, {})

return M
