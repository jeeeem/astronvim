## TODO
- Plugins
  - https://github.com/jake-stewart/multicursor.nvim
- Keybinds
  - neoclip
    - https://github.com/AckslD/nvim-neoclip.lua
    - change telescope keybind when selecting yanks
    - change telescope keybind when pasting yanks
  - astrocore
    - Change the opts into function
      - https://github.com/AstroNvim/AstroNvim/blob/2745d624d3a75d80ac2b795e120f84210df88dff/lua/astronvim/plugins/_astrocore.lua#L29-L81
  - flash.nvim
    - Remove keybind for 'S' keybind, since we usually use it for modifying whole line of code/text
  - lsp-signature
    - add toggle keybind
    - https://github.com/ray-x/lsp_signature.nvim?tab=readme-ov-file#customize-the-keymap-in-your-config
- LSP
  - configure cucumber

```lua
local ok, lsp = pcall(require, "lspconfig")

if not ok then
return
end

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

local opts = {
root_dir = lsp.util.root_pattern(root_markers),
settings = {
cucumber = {
features = {
-- "src/test/**/*.feature",
-- "features/**/*.feature",
-- "tests/**/*.feature",
-- "*specs*/**/.feature"

-- for work
"hrt/src/test/**/benefits/**/.feature",
-- "features/**/benefits/**/*.feature",
-- "src/test/**/benefits/**/*.feature",
-- "features/**/benefits/**/*.feature",
},
glue = {
-- "src/test/**/*.java",
-- "features/**/*.js",
-- "features/**/*.jsx",
-- "features/**/*.ts",
-- "features/**/*.tsx",
-- "features/**/*.php",
-- "features/**/*.py",
-- "tests/**/*.py",
-- "tests/**/*.rs",
-- "features/**/*.rs",
-- "features/**/*.rb",
-- "*specs*/**/.cs",

-- for work
"hrt/src/test/**/benefits/**/*.java",
"src/test/**/benefits/**/*.java",}
}
},
on_attach = function(client, bufnr)
print("attached to cucumber file")
vim.keymap.set('n', "gd", vim.lsp.buf.definition, { buffer = 0 })
vim.keymap.set('n', "gn", vim.diagnostic.goto_next, { buffer = 0 })
vim.keymap.set('n', "gb", vim.diagnostic.goto_prev, { buffer = 0 })
end
}

require("lvim.lsp.manager").setup("cucumber_language_server", opts)
```
  - configure autohotkey
    - https://github.com/thqby/vscode-autohotkey2-lsp?tab=readme-ov-file#vim-and-neovim

- Issue
  - Performance issue
    - smarts-split
      - investigate why is it slow to change pane from neovim window to wezterm pane
      - investigate why is it slow to change neovim window to the direction when there is no available neovim window
      - Changing direction is faster when there is no available wezterm pane
