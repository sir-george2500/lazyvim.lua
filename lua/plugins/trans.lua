return {
  "rose-pine/neovim",
  name = "rose-pine", -- Ensures the correct plugin name is used
  opts = {
    disable_background = true, -- Equivalent to transparent, specific to rose-pine
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },
}
