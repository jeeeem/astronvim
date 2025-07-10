-- Find Laravel project root
local function is_laravel_project()
    local markers = { 'artisan', 'composer.json', 'app/Http', 'config/app.php' }
    local root = vim.fs.root(0, markers)
    if root then
        -- Additional check for Laravel-specific files
        local artisan_file = root .. '/artisan'
        local composer_file = root .. '/composer.json'

        if vim.fn.filereadable(artisan_file) == 1 then
            return true, root
        elseif vim.fn.filereadable(composer_file) == 1 then
            -- Check if composer.json contains Laravel
            local ok, composer_content = pcall(vim.fn.readfile, composer_file)
            if ok then
                local content = table.concat(composer_content, '\n')
                if content:match('"laravel/framework"') or content:match('"laravel/laravel"') then
                    return true, root
                end
            end
        end
    end

    -- Fallback: check current directory
    local cwd = vim.fn.getcwd()
    if vim.fn.filereadable(cwd .. '/artisan') == 1 then
        return true, cwd
    end

    return false, nil
end

return {
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
    opts = {
      notifications = true, -- Enable/disable Laravel.nvim notifications (default: true)
      debug = false, -- Enable/disable debug error notifications (default: false)
      keymaps = true, -- Enable/disable Laravel.nvim keymaps (default: true)
      sail = {
        enabled = false, -- Enable/disable Laravel Sail integration (default: true)
        auto_detect = false, -- Auto-detect Sail usage in project (default: true)
      },
    },
    specs = {
      {
        "Saghen/blink.cmp",
        optional = true,
        opts = function(_, opts)
            if not (is_laravel_project()) then
            print "Not a laravel project"
            return
          else
            print "Laravel project"
            -- return
            local source_priority = {
              avante = 7,
              copilot = 6,
              lsp = 5,
              laravel = 4,
              snippets = 3,
              path = 2,
              buffer = 1,
            }
            -- https://code.mehalter.com/AstroNvim_user/~files/main/lua/plugins/blink-cmp-git.lua
            local default_sources = vim.tbl_get(opts, "sources", "default") or {}
            -- local per_filetype_sources = vim.tbl_get(opts, "sources", "per_filetype") or {}
            table.insert(default_sources, "laravel")
            -- table.insert(per_filetype_sources, "php")
            return require("astrocore").extend_tbl(opts, {
              sources = {
                -- per_filetype = per_filetype_sources,
                default = default_sources,
                -- per_filetype = {
                --   php = { "laravel" },
                -- },
                providers = {
                  lsp = {
                    max_items = 5,
                  },
                  snippets = {
                    max_items = 5,
                    -- https://github.com/Saghen/blink.cmp/discussions/1919
                    -- override = {
                    --   get_trigger_characters = function(_) return { ";", "." } end,
                    -- },
                  },
                  laravel = {
                    name = "laravel",
                    module = "laravel.blink_source",
                    async = true,
                    -- enabled = function()
                    --   return not vim.tbl_contains({ "snacks_picker_input", "snacks_dashboard" }, vim.bo.filetype)
                    -- end,
                    enabled = true,
                    transform_items = function(ctx, items)
                      for _, item in ipairs(items) do
                        item.kind_icon = "󰫐"
                        item.kind_name = "Laravel"
                      end
                      return items
                    end,
                    -- score_offset = 1000,
                    max_items = 5,
                  },
                },
              },
              fuzzy = {
                sorts = {
                  function(a, b)
                    local a_priority = source_priority[a.source_id]
                    local b_priority = source_priority[b.source_id]
                    if a_priority ~= b_priority then return a_priority > b_priority end
                  end,
                  -- defaults
                  "score",
                  "sort_text",
                },
              },
            })
          end
        end,
      },
    },
  },
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
