-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { -- diagnostic settings on startup
        virtual_text = true, virtual_lines = true,
        },
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      virtual_lines = {
        current_line = true,
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        swapfile = false,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr, true) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- Close hidden buffers
        ["<Leader>bh"] = {
          function() require("close_buffers").delete { type = "hidden", force = true } end,
          desc = "Close hidden buffers",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- Smart picker
        -- ["<C-p>"] = { function() Snacks.picker.smart() end, desc = "Smart find files" },
        ["<C-p>"] = { function()
              require("snacks").picker.files {
                hidden = vim.tbl_get((vim.uv or vim.loop).fs_stat ".git" or {}, "type") == "directory",
              }
            end,
            desc = "Find files",
          },
        ["<Leader>e"] = {
          function()
            local minifiles = require "mini.files"
            local buf_name = vim.api.nvim_buf_get_name(0)
            local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
            minifiles.open(path)
            minifiles.reveal_cwd()
          end,
          desc = "Toggle CWD Explorer",
        },

        -- setting a mapping to false will disable it
        -- ["<Leader>C"] = false,
        ["<Leader>/"] = false,
        ["<Leader>R"] = false,
        ["<Leader>h"] = false,
        ["<Leader>q"] = false,
        ["<Leader>n"] = false,
        ["<Leader>w"] = false,

        ["<Leader>t"] = { desc = "󰓩 Tabs" },
        ["<Leader>t0"] = { ":0tabnew<cr>", desc = "New tab before the first tab", silent = true },
        ["<Leader>te"] = { ":tabnew<cr>", desc = "New tab", silent = true },
        ["<Leader>t$"] = { ":$tabnew<cr>", desc = "New tab after the last tab", silent = true },
        ["<Leader>tE"] = { ":tabe %<cr>", desc = "New tab under the cursor file", silent = true },
        ["<Leader>tc"] = { ":tabc<cr>", desc = "Close tab", silent = true },
        ["<Leader>th"] = { ":tabm -1<cr>", desc = "Move tab to the left", silent = true },
        ["<Leader>tl"] = { ":tabm +1<cr>", desc = "Move tab to the right", silent = true },
        ["<Leader>tH"] = { ":tabm 0<cr>", desc = "Move tab to the beginning", silent = true },
        ["<Leader>tL"] = { ":tabm<cr>", desc = "Move tab to the last", silent = true },
        ["<Leader>tt"] = { ":tabn #<cr>", desc = "Go to last accessed tab", silent = true },
        ["<Leader>tf"] = false,
        ["<Leader>tn"] = false,
        ["<Leader>tp"] = false,
        ["<Leader>tu"] = false,
        ["<Leader>tv"] = false,

        -- Quickfix
        ["<F1>"] = {
          function()
            local windows = vim.fn.getwininfo()
            for _, win in pairs(windows) do
              if win["quickfix"] == 1 then
                vim.cmd.cclose()
                return
              end
            end
            vim.cmd.copen()
          end,
          desc = "Open quickfix list",
        },
        ["<F3>"] = { ":cprev<cr>", desc = "Previous quickfix list item" },
        ["<F4>"] = { ":cnext<cr>", desc = "Next quickfix list item" },
        -- setting a mapping to false will disable it
        ["\\"] = false,
        ["|"] = false,

        -- -- fix encoding issues for win/nix
        -- vim.keymap.set("n", "<A-f>", function()
        -- 	vim.api.nvim_exec2("edit ++ff=dos %", {})
        -- end, { silent = true, noremap = true })
      },

      t = {
        ["<Esc>"] = {"<C-\\><C-N>"} -- map <Esc> to exit terminal-mode
      },
    },
  },
}
