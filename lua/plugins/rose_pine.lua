-- ~/.config/nvim/lua/plugins/rosepine.lua
return {
  -- add rose-pine
  { "rose-pine/neovim", as = "rose-pine" },

  -- Configure LazyVim to load rose-pine
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
