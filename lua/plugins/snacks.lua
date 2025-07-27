
return {
  "folke/snacks.nvim",
  opts = {
    image = {
      formats = {
        "png",
        "jpg",
        "jpeg",
        "gif",
        "bmp",
        "webp",
        "tiff",
        "heic",
        "avif",
        "mp4",
        "mov",
        "avi",
        "mkv",
        "webm",
        "pdf",
        "mermaid",
      },
      force = false, -- try displaying the image, even if the terminal does not support it
      doc = {
        -- enable image viewer for documents
        -- a treesitter parser must be available for the enabled languages.
        enabled = true,
        -- render the image inline in the buffer
        -- if your env doesn't support unicode placeholders, this will be disabled
        -- takes precedence over `opts.float` on supported terminals
        inline = true,
        -- render the image in a floating window
        -- only used if `opts.inline` is disabled
        float = true,
        max_width = 80,
        max_height = 40,
        -- Set to `true`, to conceal the image text when rendering inline.
        -- (experimental)
        ---@param lang string tree-sitter language
        ---@param type snacks.image.Type image type
        conceal = function(lang, type)
          -- only conceal math expressions
          return type == "math"
        end,
      },
      img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
      -- window options applied to windows displaying image buffers
      -- an image buffer is a buffer with `filetype=image`
      wo = {
        wrap = false,
        number = false,
        relativenumber = false,
        cursorcolumn = false,
        signcolumn = "no",
        foldcolumn = "0",
        list = false,
        spell = false,
        statuscolumn = "",
      },
      cache = vim.fn.stdpath "cache" .. "/snacks/image",
      debug = {
        request = false,
        convert = false,
        placement = false,
      },
      env = {},
      -- icons used to show where an inline image is located that is
      -- rendered below the text.
      icons = {
        math = "󰪚 ",
        chart = "󰄧 ",
        image = " ",
      },
      ---@class snacks.image.convert.Config
      convert = {
        notify = true, -- show a notification on error
        ---@type snacks.image.args
        mermaid = function()
          local theme = vim.o.background == "light" and "neutral" or "dark"
          return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}" }
        end,
        ---@type table<string,snacks.image.args>
        magick = {
          default = { "{src}[0]", "-scale", "1920x1080>" }, -- default for raster images
          vector = { "-density", 192, "{src}[0]" }, -- used by vector images like svg
          math = { "-density", 192, "{src}[0]", "-trim" },
          pdf = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
        },
      },
      math = {
        enabled = false, -- enable math expression rendering
        -- in the templates below, `${header}` comes from any section in your document,
        -- between a start/end header comment. Comment syntax is language-specific.
        -- * start comment: `// snacks: header start`
        -- * end comment:   `// snacks: header end`
        typst = {
          tpl = [[
        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 12pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
        },
        latex = {
          font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
          -- for latex documents, the doc packages are included automatically,
          -- but you can add more packages here. Useful for markdown documents.
          packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
          tpl = [[
        \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
        \usepackage{${packages}}
        \begin{document}
        ${header}
        { \${font_size} \selectfont
          \color[HTML]{${color}}
        ${content}}
        \end{document}]],
        },
      },
    },
    picker = {
      win = {
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config
            -- ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["/"] = "toggle_focus",
            ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
            ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
            ["<C-c>"] = { "cancel", mode = "i" },
            ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
            ["<CR>"] = { "confirm", mode = { "n", "i" } },
            ["<Down>"] = { "list_down", mode = { "i", "n" } },
            -- ["<Esc>"] = "cancel",
            ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
            ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
            ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
            ["<Up>"] = { "list_up", mode = { "i", "n" } },
            ["<a-d>"] = { "inspect", mode = { "n", "i" } },
            ["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
            ["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
            ["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
            ["<c-a>"] = { "select_all", mode = { "n", "i" } },
            ["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
            ["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
            ["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
            ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
            ["<c-j>"] = { "list_down", mode = { "i", "n" } },
            ["<c-k>"] = { "list_up", mode = { "i", "n" } },
            ["<c-q>"] = { "qflist", mode = { "i", "n" } },
            ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
            ["<c-t>"] = { "tab", mode = { "n", "i" } },
            ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
            ["<c-r>#"] = { "insert_alt", mode = "i" },
            ["<c-r>%"] = { "insert_filename", mode = "i" },
            ["<c-r><c-a>"] = { "insert_cWORD", mode = "i" },
            ["<c-r><c-f>"] = { "insert_file", mode = "i" },
            ["<c-r><c-l>"] = { "insert_line", mode = "i" },
            ["<c-r><c-p>"] = { "insert_file_full", mode = "i" },
            ["<c-r><c-w>"] = { "insert_cword", mode = "i" },
            ["<c-w>H"] = "layout_left",
            ["<c-w>J"] = "layout_bottom",
            ["<c-w>K"] = "layout_top",
            ["<c-w>L"] = "layout_right",
            ["?"] = "toggle_help_input",
            ["G"] = "list_bottom",
            ["gg"] = "list_top",
            ["j"] = "list_down",
            ["k"] = "list_up",
            ["q"] = { "close", mode = { "n", "i" } },
            -- ["<Esc>"] = { "close", mode = { "n", "i" } },
          },
          b = {
            minipairs_disable = true,
          },
        },
      },
    },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local snack_opts = require("astrocore").plugin_opts "snacks.nvim"

        -- -- Snacks.dashboard mappins
        -- maps.n["<Leader>h"] = {
        --   function()
        --     if vim.bo.filetype == "snacks_dashboard" then
        --       require("astrocore.buffer").close()
        --     else
        --       require("snacks").dashboard()
        --     end
        --   end,
        --   desc = "Home Screen",
        -- }
        --
        -- -- Snacks.indent mappings
        -- maps.n["<Leader>u|"] =
        --   { function() require("snacks").toggle.indent():toggle() end, desc = "Toggle indent guides" }
        --
        -- -- Snacks.notifier mappings
        -- if vim.tbl_get(snack_opts, "notifier", "enabled") ~= false then
        --   maps.n["<Leader>uD"] = { function() require("snacks.notifier").hide() end, desc = "Dismiss notifications" }
        -- end
        --
        -- -- Snacks.gitbrowse mappings
        -- if vim.tbl_get(snack_opts, "gitbrowse", "enabled") ~= false then
        --   if vim.fn.executable "git" == 1 then
        --     maps.n["<Leader>g"] = vim.tbl_get(opts, "_map_sections", "g")
        --     maps.n["<Leader>go"] = { function() require("snacks").gitbrowse() end, desc = "Git browse (open)" }
        --     maps.x["<Leader>go"] = { function() require("snacks").gitbrowse() end, desc = "Git browse (open)" }
        --   end
        -- end

        -- Snacks.picker
        if vim.tbl_get(snack_opts, "picker", "enabled") ~= false then
          -- maps.n["<Leader>f"] = vim.tbl_get(opts, "_map_sections", "f")
          -- if vim.fn.executable "git" == 1 then
          --   maps.n["<Leader>g"] = vim.tbl_get(opts, "_map_sections", "g")
          --   maps.n["<Leader>gb"] = { function() require("snacks").picker.git_branches() end, desc = "Git branches" }
          --   maps.n["<Leader>gc"] = {
          --     function() require("snacks").picker.git_log() end,
          --     desc = "Git commits (repository)",
          --   }
          --   maps.n["<Leader>gC"] = {
          --     function() require("snacks").picker.git_log { current_file = true, follow = true } end,
          --     desc = "Git commits (current file)",
          --   }
          --   maps.n["<Leader>gt"] = { function() require("snacks").picker.git_status() end, desc = "Git status" }
          --   maps.n["<Leader>gT"] = { function() require("snacks").picker.git_stash() end, desc = "Git stash" }
          -- end
          -- maps.n["<Leader>f<CR>"] =
          --   { function() require("snacks").picker.resume() end, desc = "Resume previous search" }
          -- maps.n["<Leader>f'"] = { function() require("snacks").picker.marks() end, desc = "Find marks" }
          -- maps.n["<Leader>fl"] = {
          --   function() require("snacks").picker.lines() end,
          --   desc = "Find lines",
          -- }
          -- maps.n["<Leader>fa"] = {
          --   function() require("snacks").picker.files { dirs = { vim.fn.stdpath "config" }, desc = "Config Files" } end,
          --   desc = "Find AstroNvim config files",
          -- }
          -- maps.n["<Leader>fb"] = { function() require("snacks").picker.buffers() end, desc = "Find buffers" }
          -- maps.n["<Leader>fc"] =
          --   { function() require("snacks").picker.grep_word() end, desc = "Find word under cursor" }
          -- maps.n["<Leader>fC"] = { function() require("snacks").picker.commands() end, desc = "Find commands" }
          -- maps.n["<Leader>ff"] = {
          --   function()
          --     require("snacks").picker.files {
          --       hidden = vim.tbl_get((vim.uv or vim.loop).fs_stat ".git" or {}, "type") == "directory",
          --     }
          --   end,
          --   desc = "Find files",
          -- }
          -- maps.n["<Leader>fF"] = {
          --   function() require("snacks").picker.files { hidden = true, ignored = true } end,
          --   desc = "Find all files",
          -- }
          -- maps.n["<Leader>fg"] = { function() require("snacks").picker.git_files() end, desc = "Find git files" }
          -- maps.n["<Leader>fh"] = { function() require("snacks").picker.help() end, desc = "Find help" }
          -- maps.n["<Leader>fk"] = { function() require("snacks").picker.keymaps() end, desc = "Find keymaps" }
          -- maps.n["<Leader>fm"] = { function() require("snacks").picker.man() end, desc = "Find man" }
          -- maps.n["<Leader>fn"] =
          --   { function() require("snacks").picker.notifications() end, desc = "Find notifications" }
          -- maps.n["<Leader>fo"] = { function() require("snacks").picker.recent() end, desc = "Find old files" }
          -- maps.n["<Leader>fO"] = {
          --   function() require("snacks").picker.recent { filter = { cwd = true } } end,
          --   desc = "Find old files (cwd)",
          -- }
          maps.n["<Leader>fp"] = {
            function()
              require("snacks").picker.projects {
                finder = "recent_projects",
                format = "file",
                dev = { "~/dev", "~/projects" },
                confirm = "load_session",
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "package.json", "Makefile", "artisan" },
                recent = true,
                matcher = {
                  frecency = true, -- use frecency boosting
                  sort_empty = true, -- sort even when the filter is empty
                  cwd_bonus = false,
                },
                sort = { fields = { "score:desc", "idx" } },
                win = {
                  preview = { minimal = true },
                  input = {
                    keys = {
                      -- every action will always first change the cwd of the current tabpage to the project
                      ["<c-e>"] = { { "tcd", "picker_explorer" }, mode = { "n", "i" } },
                      ["<c-f>"] = { { "tcd", "picker_files" }, mode = { "n", "i" } },
                      ["<c-g>"] = { { "tcd", "picker_grep" }, mode = { "n", "i" } },
                      ["<c-r>"] = { { "tcd", "picker_recent" }, mode = { "n", "i" } },
                      ["<c-w>"] = { { "tcd" }, mode = { "n", "i" } },
                      ["<c-t>"] = {
                        function(picker)
                          vim.cmd "tabnew"
                          Snacks.notify "New tab opened"
                          picker:close()
                          Snacks.picker.projects()
                        end,
                        mode = { "n", "i" },
                      },
                    },
                  },
                },
              }
            end,
            desc = "Find projects",
          }
          -- maps.n["<Leader>fr"] = { function() require("snacks").picker.registers() end, desc = "Find registers" }
          -- maps.n["<Leader>fs"] = { function() require("snacks").picker.smart() end, desc = "Find buffers/recent/files" }
          -- maps.n["<Leader>ft"] = { function() require("snacks").picker.colorschemes() end, desc = "Find themes" }
          -- if vim.fn.executable "rg" == 1 then
          --   maps.n["<Leader>fw"] = { function() require("snacks").picker.grep() end, desc = "Find words" }
          --   maps.n["<Leader>fW"] = {
          --     function() require("snacks").picker.grep { hidden = true, ignored = true } end,
          --     desc = "Find words in all files",
          --   }
          -- end
          -- maps.n["<Leader>fu"] = { function() require("snacks").picker.undo() end, desc = "Find undo history" }
          -- maps.n["<Leader>lD"] = { function() require("snacks").picker.diagnostics() end, desc = "Search diagnostics" }
          -- maps.n["<Leader>ls"] = {
          --   function()
          --     local aerial_avail, aerial = pcall(require, "aerial")
          --     if aerial_avail and aerial.snacks_picker then
          --       aerial.snacks_picker()
          --     else
          --       require("snacks").picker.lsp_symbols()
          --     end
          --   end,
          --   desc = "Search symbols",
          -- }
        end

        -- Snacks.zen mappings
        -- if vim.tbl_get(snack_opts, "zen", "enabled") ~= false then
        --   maps.n["<Leader>uZ"] = { function() require("snacks").toggle.zen():toggle() end, desc = "Toggle zen mode" }
        -- end
      end,
    },
  },
}
