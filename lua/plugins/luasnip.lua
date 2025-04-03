return {
  "L3MON4D3/LuaSnip",
  config = function(plugin, opts)
    -- include the default astronvim config that calls the setup call
    require("astronvim.plugins.configs.luasnip")(plugin, opts)
    -- load snippets paths
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/lua/luasnippets" },
    })
    -- require("luasnip.loaders.from_lua").lazy_load({ include = { "all", "cpp", "lua" } })
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets" },
    })
    
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node

    ls.add_snippets("lua", s("bloop", { t"Wow!"}))
  end,
}
