-- todo: place into xalpha file ?
local if_nil = vim.F.if_nil
local art = require("modu.art_art")

-- TODO: be able to call the asci artwork from a different file
local default_header = {
    type = "text",
    -- val = art.zero,
    val = " ",
    opts = {
        position = "center",
        hl = "Art",
        -- wrap = "overflow";
    },
}

local footer = {
    type = "text",
    val = " ",
    opts = {
        position = "center",
        hl = "Normal",
    },
}

local default_terminal = {
    type = "terminal",
    command = nil,
    width = 69,
    height = 8,
    opts = {
        redraw = true,
        window_config = {},
    },
}

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 3,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local main = {
    type = "text",
    -- val = art.zero,
    opts = {
        position = "center",
        hl = "Art",
        -- wrap = "overflow";
    },
}

local buttons = {
    type = "text",
    val = "   ",
    -- val = {
        -- button("e", "  New file", "<cmd>ene <CR>"),
        -- button("SPC f f", "󰈞  Find file"),
        -- button("SPC f h", "󰊄  Recently opened files"),
        -- button("SPC f r", "  Frecency/MRU"),
        -- button("SPC f g", "󰈬  Find word"),
        -- button("SPC f m", "  Jump to bookmarks"),
        -- button("SPC s l", "  Open last session"),
    -- },
    opts = {
        spacing = 1,
        position = "center",
        hl = "Art",
    },
}

local section = {
    terminal = default_terminal,
    header = default_header,
    main = main,
    buttons = buttons,
    footer = footer,
}

local config = {
    layout = {
        { type = "padding", val = 2 },
        section.header,
        { type = "padding", val = 2 },
        section.buttons,
        section.footer,
    },
    opts = {
        margin = 5,
    },
}

return {
    button = button,
    section = section,
    config = config,
    -- theme config
    leader = leader,
    -- deprecated
    opts = config,
}

