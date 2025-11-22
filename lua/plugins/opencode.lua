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
    -- https://github.com/NickvanDyke/opencode.nvim/blob/main/lua/opencode/config.lua
    vim.g.opencode_opts = {
      contexts = {
        ["@selection"] = function(ctx) return ctx:visual_selection() end,
        ["@this"] = function(context) return context:this() end,
        ["@buffer"] = function(context) return context:buffer() end,
        ["@buffers"] = function(context) return context:buffers() end,
        ["@visible"] = function(context) return context:visible_text() end,
        ["@diagnostics"] = function(context) return context:diagnostics() end,
        ["@quickfix"] = function(context) return context:quickfix() end,
        ["@diff"] = function(context) return context:git_diff() end,
        ["@grapple"] = function(context) return context:grapple_tags() end,
      },
      
      ---@type opencode.Provider
      provider = {
        toggle = function(self)
          -- Called by `require("opencode").toggle()`
        end,
        start = function(self)
          -- Called when sending a prompt or command to `opencode` but no process was found.
          -- `opencode.nvim` will poll for a couple seconds waiting for one to appear.
        end,
        show = function(self)
          -- Called when a prompt or command is sent to `opencode`,
          -- *and* this provider's `toggle` or `start` has previously been called
          -- (so as to not interfere when `opencode` was started externally).
        end,
      },
    }

    -- Required for `vim.g.opencode_opts.auto_reload`.
    vim.o.autoread = true
  end,

  specs = {
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        local prefix = "<Leader>O"
        maps.n[prefix] = { desc = require("astroui").get_icon("OpenCode", 1, true) .. "OpenCode" }
        maps.n[prefix .. "a"] = {
          function() require("opencode").ask "@cursor: " end,
          desc = "Ask about this",
        }
        maps.n[prefix .. "+"] = {
          function() require("opencode").prompt("@buffer", { append = true }) end,
          desc = "Add buffer to prompt",
        }
        maps.n[prefix .. "e"] = {
          function() require("opencode").prompt "Explain @cursor and its context" end,
          desc = "Explain this code",
        }
        maps.n[prefix .. "s"] = {
          function() require("opencode").select() end,
          desc = "Select prompt",
        }

        maps.v[prefix] = { desc = require("astroui").get_icon("OpenCode", 1, true) .. "OpenCode" }
        maps.v[prefix .. "a"] = {
          function() require("opencode").ask "@selection: " end,
          desc = "Ask about selection",
        }
        maps.v[prefix .. "+"] = {
          function() require("opencode").prompt("@selection", { append = true }) end,
          desc = "Add selection to prompt",
        }
        maps.v[prefix .. "s"] = {
          function() require("opencode").select() end,
          desc = "Select prompt",
        }
      end,
    },
    { "AstroNvim/astroui", opts = { icons = { OpenCode = "" } } },
  },
}
