local M = {}

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
function M.copy(args)
	return args[1]
end

function M.insert_at_the_top(args, user_args)
  local bufnr = vim.api.nvim_get_current_buf()
  -- Insert at line 0
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { user_args, "" })
end

return M
