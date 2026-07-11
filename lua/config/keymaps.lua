-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Duplicate current line
vim.keymap.set("n", "<leader>dt", ":t.<CR>", { silent = true, desc = "Duplicate line" })

-- Copy whole file to system clipboard
vim.keymap.set("n", "<leader>Ca", 'ggVG"+y', { silent = true, desc = "Copy whole file" })

-- Format file (LazyVim also provides <leader>cf)
vim.keymap.set("n", "<leader>hf", function()
  vim.lsp.buf.format({ async = true })
end, { silent = true, desc = "Format file (LSP)" })

-- Define a command for sorting imports
vim.api.nvim_create_user_command("SortImports", "silent !import-sort %", {})
