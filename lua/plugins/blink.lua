return {
  "Saghen/blink.cmp",
  -- enabled = function() return not vim.tbl_contains({ "snacks_picker_input", "snacks_dashboard"}, vim.bo.filetype) end,
  opts = {
    completion = {
      trigger = {
			  show_on_insert_on_trigger_character = false,
		  },
      menu = {
        draw = {
          columns = {
            -- rearrange these as necessary to match desired look
            { "label", "label_description" },
            { "kind_icon", "kind", "source_name", gap = 1 },
            -- { "source_name"},
          },
        },
      },
    },
  },
}
