return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.java" },
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      settings = {
        -- java = {
        --   configuration = {
        --     runtimes = {
        --       {
        --         name = "JavaSE-11",
        --         path = "/usr/lib/jvm/java-11-openjdk/",
        --       },
        --     },
        --   },
        -- },
        format = {
          enabled = false,
          settings = { -- you can use your preferred format style
            url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
            profile = "GoogleStyle",
          },
        },
      },
    },
  },
}
