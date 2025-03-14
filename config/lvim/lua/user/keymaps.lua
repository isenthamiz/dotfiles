lvim.keys.normal_mode["<Tab>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":BufferLineCyclePrev<CR>"

-- Change window navigation from Ctrl+w to Option+w
vim.api.nvim_set_keymap('n', '<A-w>', '<C-w>', { noremap = true, silent = true })
