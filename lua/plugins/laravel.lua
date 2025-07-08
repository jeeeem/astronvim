return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "php" })
      end
    end,
  },
  {
    "adibhanna/laravel.nvim",
    ft = { "php" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      -- {
      --   "AstroNvim/astrocore",
      --   opts = {
      --     mappings = {
      --       n = {
      --         ["<Leader>Ls"] = {
      --           function() vim.cmd "LaravelStatus" end,
      --           desc = "Laravel Status",
      --         },
      --       },
      --     },
      --   },
      -- },
    },
    cmd = {
      "LaravelStatus",
      "LaravelSetRoot",
      "LaravelController",
      "LaravelModel",
      "LaravelView",
      "LaravelGoto",
      "LaravelRoute",
      "LaravelMake",
      "LaravelSchema",
      "LaravelSchemaExport",
      "LaravelArchitecture",
      "LaravelCompletions",
      "LaravelClearCache",
      "LaravelInstallIdeHelper",
      "LaravelIdeHelperClean",
      "LaravelRemoveIdeHelper",
      "LaravelIdeHelperCheck",
      "LaravelIdeHelper",
      "LaravelDumps",
      "LaravelDumpsInstall",
      "LaravelDumpsEnable",
      "LaravelDumpsDisable",
      "LaravelDumpsToggle",
      "LaravelDumpsClear",
      "LaravelDumpsSearch",
      "LaravelDumpsClearSearch",
      "Composer",
      "ComposerRequire",
      "ComposerRemove",
      "ComposerDependencies",
      "Artisan",
      "Sail",
      "SailUp",
      "SailDown",
      "SailRestart",
      "SailTest",
      "SailShare",
      "SailShell",
      "SailLogs",
      "SailStatus",
      "SailStop",
      "SailOpen",
    },
    -- keys = {
    --   { "<leader>la", ":Artisan<cr>", desc = "Laravel Artisan" },
    --   { "<leader>lc", ":Composer<cr>", desc = "Composer" },
    --   { "<leader>lr", ":LaravelRoute<cr>", desc = "Laravel Routes" },
    --   { "<leader>lm", ":LaravelMake<cr>", desc = "Laravel Make" },
    -- },
    -- event = { "VeryLazy" },
    config = function()
      require("laravel").setup {
        notifications = true, -- Enable/disable Laravel.nvim notifications (default: true)
        debug = false, -- Enable/disable debug error notifications (default: false)
        keymaps = true, -- Enable/disable Laravel.nvim keymaps (default: true)
        sail = {
          enabled = true, -- Enable/disable Laravel Sail integration (default: true)
          auto_detect = true, -- Auto-detect Sail usage in project (default: true)
        },
      }
    end,
    specs = {
      {
        "Saghen/blink.cmp",
        optional = true,
        opts = function(_, opts)
          if _G.laravel_nvim and _G.laravel_nvim.project_root then
            opts.sources = {
              default = { "laravel", "lsp", "path", "snippets", "buffer" },
              providers = {
                laravel = {
                  name = "laravel",
                  module = "laravel.blink_source",
                },
              },
            }
          end
        end,
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      opts.mappings.n.gD = {
        function()
          if not (_G.laravel_nvim and _G.laravel_nvim.project_root) then
            -- Default to declaration for everything else
            if vim.lsp.buf.declaration then
              vim.lsp.buf.declaration()
            else
              -- Final fallback to built-in declaration
              vim.cmd "normal! gD"
            end
            -- vim.notify("Not in a Laravel project", vim.log.levels.ERROR)
            return
          else
            -- Check if this looks like a Laravel-specific pattern first
            --
            local navigate = require "laravel.navigate"
            if navigate.is_laravel_navigation_context() then
              -- This is a Laravel-specific context, try Laravel navigation
              local success = pcall(navigate.goto_laravel_string)
              if success then
                return -- Laravel navigation succeeded
              end
            end
          end
        end,
        desc = "Laravel: Go to definition (Laravel strings or LSP) / Go to declaration",
      }
    end,
  },
}
