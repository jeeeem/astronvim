return {
  "ravitemer/mcphub.nvim",
  commit = "0b92eae385da36601f1311b30122c18de9e273e9",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  },
  -- build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
  build = "bundled_build.lua",
  event = "User AstroFile",
  cmd = "MCPHub",
  opts = {
    use_bundled_binary = true,  -- Use local `mcp-hub` binary
    port = 3000,
    config = vim.fn.expand "~/mcpservers.json",
    log = {
      level = vim.log.levels.WARN,
      to_file = false,
      file_path = nil,
      prefix = "MCPHub",
    },
    workspace = {
      enabled = true, -- Default: true
      look_for = { ".mcphub/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" },
      reload_on_dir_changed = true,
      port_range = { min = 40000, max = 41000 },
      get_port = nil, -- Optional custom port function
    },
    -- global_env = {
    --   "DBUS_SESSION_BUS_ADDRESS", -- Array-style: uses os.getenv()
    --   API_KEY = os.getenv("API_KEY"), -- Hash-style: explicit value
    -- }
  },
  specs = {
    {
      "olimorris/codecompanion.nvim",
      optional = true,
      opts = {
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              show_result_in_chat = true,
              make_vars = true,
              make_slash_commands = true,
            },
          },
        },
      },
    },
    {
      "yetone/avante.nvim",
      optional = true,
      opts = {
        system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          return hub:get_active_servers_prompt()
        end,
        -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
        custom_tools = function()
          return {
            require("mcphub.extensions.avante").mcp_tool(),
          }
        end,
      },
    },
  },
}
