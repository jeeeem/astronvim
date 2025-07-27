local M = {}

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
function M.copy(args)
	return args[1]
end

function M.say_hello(name)
  print("Hello, " .. name)
end

function M.add(a, b)
  return a + b
end


return M
