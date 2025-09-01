vim.pack.add {
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = "https://github.com/mason-org/mason.nvim", },
    { src = "https://github.com/catppuccin/nvim",      name = "catppuccin" },
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/vague2k/vague.nvim",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/onsails/lspkind.nvim",
    "https://github.com/ray-x/lsp_signature.nvim",
    "https://github.com/folke/which-key.nvim",

    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim"
}

require("mason").setup()
require("oil").setup()
-- require("mini.pick").setup()
require("lspkind").init {}
require "lsp_signature".setup {
    floating_window_above_cur_line = true
}

vim.o.termguicolors = true
vim.wo.relativenumber = true
vim.wo.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.g.mapleader = " "
vim.keymap.set('i', "jk", "<Esc>")
vim.o.winborder = "rounded"

vim.o.foldmethod = "indent"
vim.o.foldlevel = 99

vim.cmd [[colorscheme vague]]

local in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil

if in_wsl then
    vim.g.clipboard = {
        name = 'wsl clipboard',
        copy = { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
        paste = { ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))', ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))' },
        cache_enabled = true
    }
end


function file_makerun()
    local ft = vim.bo.filetype
    local filename = vim.fn.expand("%:t")
    local dir = vim.fn.expand("%:p:h")
    if ft == "cpp" then
        vim.cmd(string.format("vnew | terminal cd %s && g++ -Wall -Wextra -o %s.sto %s && ./%s.sto", dir, filename, filename, filename))
        vim.cmd "wincmd l"
        vim.cmd "wincmd h"
    end
end
function file_clear()
    local ft = vim.bo.filetype
    local dir = vim.fn.expand("%:p:h")
    if ft == "cpp" then
        vim.cmd(string.format("vnew | terminal cd %s && rm -fv *.sto", dir))
        vim.cmd "wincmd l"
        vim.cmd "wincmd h"
    end
end
function file_maketerminal()
    local dir = vim.fn.expand("%:p:h")
    vim.cmd(string.format("vnew | terminal cd %s && zsh", dir))
    vim.cmd "wincmd r"
    vim.cmd "wincmd l"
    vim.cmd "vertical resize 60"
end

vim.keymap.set({ "n", "v" }, "<leader>o", ":update<CR> :source<CR>", { desc = "Resource Config" })
vim.keymap.set({ "n", "v" }, "<leader>e", ":Oil<CR>", { desc = "Open explorer" })
vim.keymap.set({ "n", "v" }, "<leader>y", '\"+y', { desc = "Yank from clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '\"+p', { desc = "Paste from clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })
vim.keymap.set({ "n", "v" }, "<leader>ff", ':Pick files<CR>', { desc = "Pick files" })
vim.keymap.set({ "n", "v" }, "<leader>mt", file_maketerminal, { desc = "Make terminal" })
vim.keymap.set({ "n", "v" }, "<leader>mr", file_makerun, { desc = "Run current file" })
vim.keymap.set({ "n", "v" }, "<leader>mc", file_clear, { desc = "Clear temporary executable files" })

-- in your nvim/lua config
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
vim.keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float(nil, {
        focus = false,       -- don't move cursor into the float
        scope = "cursor",    -- show diagnostics under cursor
        border = "rounded",  -- optional rounded border
    })
end, { desc = "Show diagnostic" })

function add_whichkey_groups()
    local wk = require "which-key"
    wk.add {
        { "<leader>f", group = "file" },
        { "<leader>m", group = "make" },
    }
end
add_whichkey_groups()

function setup_cmp()
    -- Customization for the autocomplete menu
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
    vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

    vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
    vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
    vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

    vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
    vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
    vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

    vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
    vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
    vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

    vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
    vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
    vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
    vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
    vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

    vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
    vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

    vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
    vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
    vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

    vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
    vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
    vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

    vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
    vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
    vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })

    local cmp = require 'cmp'
    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        window = {
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 0,
                border = "none"
            },
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        }, {
            { name = 'buffer' },
        }),

        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                -- Add nice icons (requires devicons or similar)
                --
                local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    (" .. (strings[2] or "") .. ")"

                return kind
            end,
        },
    })
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig')['lua_ls'].setup {
        capabilities = capabilities
    }
    require('lspconfig')['clangd'].setup {
        capabilities = capabilities
    }
end

setup_cmp()
