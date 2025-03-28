return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.java" },
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-21",
                path = "C:/Users/jberen/scoop/apps/openjdk21/current/",
              },
            },
          },
        },
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
