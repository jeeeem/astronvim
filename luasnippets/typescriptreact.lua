-- TODO:
-- template for page.tsx
--  export default {async} function NamedOfTheFile(){
--  return ()
--  }
-- 

local util = require "util"
return {
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
}
