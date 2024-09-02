if vim.fn.is_module_available("gruvbox") then require("gruvbox").setup {
    undercurl = true,
    underline = false, bold = true,
    italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
    },
    strikethrough = false,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {
        -- Normal = { bg = "" },
        CursorLine = { bg = "" },
        CursorLineNr = { bg = "" },
        LineNr = { bg = "" },
        SignColumn = { bg = "" },
        ["Todo"] = { bg = "", fg = "" },
       Cursor = { bg = "#C3A40C" },
    },
    dim_inactive = false,
    transparent_mode = false -- not vim.g.neovide
}
end
