-- TODO:
-- template for page.tsx
--  export default {async} function NamedOfTheFile(){
--  return ()
--  }
-- 
local util = require "util"

return {
  s({ trig = "tsr", name = "test typescriptreact snippet" }, {
    t { '"typescriptreact snippet loaded";' },
  }),
  -- TODO: add use client on the top of the file
  s({ trig = "ucl", name = "use client (NextJS))" }, {
    t { '"use client";' },
  }),
  s(
    { trig = "cl", name = "console log" },
    fmt(
      [[
      console.log({})
      ]],
      { i(1, "args") }
    )
  ),
  -- reference https://github.com/L3MON4D3/LuaSnip/issues/1219
  s({ trig = "usc", name="use client", desc="insert use_client at the top of the file"}, i(0), {
    callbacks = {
      [-1] = { -- -1 refers to the snippet as a whole
        [events.pre_expand] = function(_, _)
          util.insert_at_the_top(_, "\"use client\";")
        end,
      },
    },
  }),
}
