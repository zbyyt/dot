return {
    "VonHeikemen/lsp-zero.nvim",
        event = 'VeryLazy',
        dependencies = { -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim", -- Optional
                cmd = { "Mason", "MasonUpdate",},
                build = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,},
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },     -- Required
            { "hrsh7th/cmp-path" },     -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip",
                run = "make install_jsregexp"
            },     -- Required
        },
        config = function()
            -- LSP-ZERO SETUP
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = true})
end)

local lspc = require('lspconfig')

lspc.lua_ls.setup(lsp.nvim_lua_ls()) -- lua
lspc.clangd.setup{}

lsp.setup()

-- HOW TO ADD BORDERS TO MENUS? ##############################
-- DISABLE BELOW?
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
         vim.lsp.handlers.hover, {
           -- Use a sharp border with `FloatBorder` highlights
           border = "single",
           -- add the title in hover float window
           title = "hover"
       	}
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
         vim.lsp.handlers.signature_help, {
           -- Use a sharp border with `FloatBorder` highlights
           border = "single"
         }
       )
vim.diagnostic.config{
  float={border= "single" },
  virtual_text = true,
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = false,
}
--local lsp = require('lsp-zero').preset({
 --   name = 'minimal',
  --  set_lsp_keymaps = true,
   -- manage_nvim_cmp = true,
    --border = 'rouded',
--  })

        end
}
