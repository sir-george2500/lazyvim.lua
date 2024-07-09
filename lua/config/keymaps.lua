-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.api.nvim_set_keymap("n", "<leader>D", ":t.<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>Ca", 'ggVG"+y', { noremap = true, silent = true })

--file formating
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.api.nvim_set_keymap(
  "n",
  "<leader>hf",
  "ggVG<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
  { noremap = true, silent = true }
)
