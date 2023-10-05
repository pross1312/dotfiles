local my_info = { bold = true, bg = "#4f1227", fg = "#ff224b" } -- FIXME: TODO: NOTE:
require("gruvbox").setup({
    undercurl = true,
    underline = false,
    bold = true,
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
        CursorLine = { bg = "" },
        CursorLineNr = { bg = "" },
        ["Todo"] = my_info,
        ["@text.todo.comment"] = my_info,
        ["@text.note.comment"] = my_info,
        ["@text.danger.comment"] = my_info,
        ["@text.warning.comment"] = my_info,
        ["@punctuation.delimiter.comment"] = my_info,
       Cursor = { bg = "#C3A40C" },
    },
    dim_inactive = false,
    transparent_mode = not vim.g.neovide
})
