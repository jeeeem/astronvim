return {
  "akinsho/toggleterm.nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local astro = require "astrocore"
        local maps = opts.mappings
        local get_icon = require("astroui").get_icon

        -- maps.n["<Leader>T"] = vim.tbl_get(opts, "_map_sections", "t")
        maps.n["<Leader>T"] = { desc = get_icon("Terminal", 1, true) .. "Terminal" }

        if vim.fn.executable "lazygit" == 1 then
          maps.n["<Leader>g"] = vim.tbl_get(opts, "_map_sections", "g")
          maps.n["<Leader>gg"] = {
            function()
              local worktree = astro.file_worktree()
              local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
                or ""
              astro.toggle_term_cmd("lazygit " .. flags)
            end,
            desc = "ToggleTerm lazygit",
          }
          maps.n["<Leader>Tl"] = maps.n["<Leader>gg"]
        end
        if vim.fn.executable "node" == 1 then
          maps.n["<Leader>Tn"] = { function() astro.toggle_term_cmd "node" end, desc = "ToggleTerm node" }
        end
        local gdu = vim.fn.has "mac" == 1 and "gdu-go" or "gdu"
        if vim.fn.executable(gdu) == 1 then
          maps.n["<Leader>Tu"] = { function() astro.toggle_term_cmd(gdu) end, desc = "ToggleTerm gdu" }
        end
        if vim.fn.executable "btm" == 1 then
          maps.n["<Leader>Tt"] = { function() astro.toggle_term_cmd "btm" end, desc = "ToggleTerm btm" }
        end
        local python = vim.fn.executable "python" == 1 and "python" or vim.fn.executable "python3" == 1 and "python3"
        if python then
          maps.n["<Leader>Tp"] = { function() astro.toggle_term_cmd(python) end, desc = "ToggleTerm python" }
        end
        maps.n["<Leader>Tf"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
        maps.n["<Leader>Th"] =
          { "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "ToggleTerm horizontal split" }
        maps.n["<Leader>Tv"] = { "<Cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "ToggleTerm vertical split" }
        maps.n["<F7>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" }
        maps.t["<F7>"] = { "<Cmd>ToggleTerm<CR>", desc = maps.n["<F7>"].desc }
        maps.i["<F7>"] = { "<Esc>" .. maps.t["<F7>"][1], desc = maps.n["<F7>"].desc }
        maps.n["<C-'>"] = maps.n["<F7>"] -- requires terminal that supports binding <C-'>
        maps.t["<C-'>"] = maps.t["<F7>"] -- requires terminal that supports binding <C-'>
        maps.i["<C-'>"] = maps.i["<F7>"] -- requires terminal that supports binding <C-'>
      end,
    },
  },
}
