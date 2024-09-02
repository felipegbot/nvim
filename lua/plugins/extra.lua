vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.updatetime = 50
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

vim.keymap.set("n", ";", ":")
vim.keymap.set("v", "v", "<ESC> 0 v $")
-- split windows
vim.keymap.set({ "n" }, "<leader>hs", "<cmd> split <CR>")
vim.keymap.set({ "n" }, "<leader>vs", "<cmd> vsplit <CR>")
vim.keymap.set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>')

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle <CR>")
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  vim.g.autoformat = false
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.g.autoformat = true
end, {
  desc = "Re-enable autoformat-on-save",
})

vim.api.nvim_create_user_command("FT", function()
  vim.g.autoformat = not vim.g.autoformat
  if vim.g.autoformat then
    vim.notify("Autoformat-on-save enabled", vim.log.levels.INFO)
  else
    vim.notify("Autoformat-on-save disabled", vim.log.levels.INFO)
  end
end, {
  desc = "Toggle autoformat-on-save",
})

return {
  { "sainnhe/sonokai" },
  { "wakatime/vim-wakatime", lazy = false },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },
  {
    "vyfor/cord.nvim",
    build = "./build",
    event = "VeryLazy",
    opts = {},
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  { "f-person/git-blame.nvim" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = true, auto_trigger = true },
    },
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<M-i>",
            prev = "<M-o>",
            next = "<M-p>",
          },
        },
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "sonokai",
    },
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.comment").setup()
      require("mini.indentscope").setup()
      require("mini.surround").setup()
      require("mini.tabline").setup()
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({})
    end,
  },
  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },
}
-- base config
