-- References tutorials
-- https://github.com/L3MON4D3/LuaSnip#official-docs-and-examples
-- https://www.youtube.com/watch?v=Dn800rlPIho
-- https://www.youtube.com/watch?v=KtQZRAkgLqo
-- https://www.youtube.com/watch?v=aNWx-ym7jjI
-- https://github.com/mireq/luasnip-snippets

-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#snip-env-diagnostics
-- local ls = require("luasnip")
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet

return {
  s("all", t "all snippets loaded!"),
}
