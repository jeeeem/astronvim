-- -- Listen for opencode events
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "OpencodeEvent",
--   callback = function(args)
--     -- See the available event types and their properties
--     -- vim.notify(vim.inspect(args.data), vim.log.levels.DEBUG)
--     -- Do something interesting, like show a notification when opencode finishes responding
--     if args.data.type == "session.idle" then
--       vim.notify("opencode finished responding", vim.log.levels.INFO)
--     end
--   end,
-- })

return {
  "NickvanDyke/opencode.nvim",
  enabled = true,
  config = function()
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`
      port =  nil,
      on_opencode_not_found = function()
        -- Ignore error so users can safely exclude `snacks.nvim` dependency without overriding this function.
        -- Could incidentally hide an unexpected error in `snacks.terminal`, but seems unlikely.

        -- Don't call built-in terminal, I preferred to use opencode in Zellij
        -- pcall(require("opencode.terminal").open)
      end,
      on_send = function()
        -- "if exists" because user may alternate between embedded and external opencode.
        -- `opts.on_opencode_not_found` comments also apply here.
        pcall(require("opencode.terminal").show_if_exists)
      end,
    }

    -- Required for `vim.g.opencode_opts.auto_reload`
    vim.opt.autoread = true
  end,
}
