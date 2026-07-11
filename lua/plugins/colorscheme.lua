return {
  -- rose-pine with a transparent background
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      disable_background = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- tell LazyVim to load rose-pine
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
