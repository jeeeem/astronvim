return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  dependencies = {
    {
      "AstroNvim/astrocore",
      -- Workaround to set "global_keymaps_prefix", and to override astronvim rename function
      -- Its still working if you hit the <Leader>R key while the whichkey
      -- popup still not yet showing and without entering another keymap
      -- but if the <Leader>R is disable. Only the kulala global keymaps will works
      opts = function()  require("kulala.config.keymaps").setup_global_keymaps() end,
    },
  },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    lsp = { on_attach = function(...) return require("astrolsp").on_attach(...) end },
    ui = {
      display_mode = "split",
      split_direction = "horizontal",
      -- default view: "body" or "headers" or "headers_body" or "verbose" or fun(response: Response)
      default_view = "headers_body", ---@type "body"|"headers"|"headers_body"|"verbose"|fun(response: Response)
      show_request_summary = true,
      report = {
        -- possible values: true | false | "on_error"
        show_script_output = "on_error",
        -- possible values: true | false | "on_error" | "failed_only"
        show_asserts_output = "on_error",
        -- possible values: true | false | "on_error"
        show_summary = true,
        headersHighlight = "Special",
        successHighlight = "String",
        errorHighlight = "Error",
      },
    },
  },
  config = function(_, opts)
    require("kulala").setup(opts)
    if opts.global_keymaps_prefix then
      require("astrocore").set_mappings {
        n = {
          [opts.global_keymaps_prefix] = { desc = require("astroui").get_icon("KulalaNvim", 1, true) .. "KulalaNvim" },
        },
      }
    end
  end,
}
