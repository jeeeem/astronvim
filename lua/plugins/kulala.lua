return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>r",
    lsp = { on_attach = function(...) return require("astrolsp").on_attach(...) end },
    ui = {
      display_mode = "split",
      split_direction = "horizontal",
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
