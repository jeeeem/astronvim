return {
  s({ trig = "php", name = "test php snippet" }, {
    t { '"php snippet loaded";' },
  }),
  s(
    { trig = "beforeEach", name = "beforeEach() Pest function" },
    fmt(
      [[
        beforeEach(function(){{
            $this->{};
        }});
        ]],
      {
        i(1, "Start typing..."),
      }
    )
  ),
  s(
    { trig = "__construct", name = "php constructor" },
    fmt(
      [[
          public function __construct({})
          {{
            {}
          }}

        ]],
      {
        i(1, "args"),
        i(2, "content"),
      }
    )
  ),
  s(
    { trig = "class", name = "php class" },
    fmt(
      [[
        <?php

        class {}
        {{
          {}
        }}
        ]],
      {
        i(1, "ExampleClass"),
        i(2, "start typing..."),
      }
    )
  ),
  s(
    { trig = "<?", name = "php file" },
    fmt(
      [[
        <?php

        {}
        ]],
      {
        i(1, "start typing..."),
      }
    )
  ),
  s(
    { trig = "fun", name = "public function ()" },
    fmt(
      [[
          public function {}({}): {}
          {{
            {}
          }}
        ]],
      {
        i(1, "function_name"),
        i(2, "args"),
        i(3, "return"),
        i(4, "content"),
      }
    )
  ),
  s(
    { trig = "test", name = "Pest test" },
    fmt(
      [[
        test('{}', function() {{
          expect({})->{}({});
        }});
        ]],
      { i(1, "test name"), i(2, "expectation"), i(3, "is"), i(4, "actual") }
    )
  ),
  s(
    { trig = "it", name = "Pest test" },
    fmt(
      [[
        it('{}', function() {{
          expect({})->{}({});
        }});
        ]],
      { i(1, "test name"), i(2, "expectation"), i(3, "is"), i(4, "actual") }
    )
  ),
}
