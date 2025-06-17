-- /home/dvtuong/programming/test/nim/main.nim(1, 6) Error: closing " expected
vim.b.current_compiler = "nimble"
vim.opt.makeprg = "nimble build"
vim.opt.errorformat = "%-GHint: %m, %E%f(%l\\, %c) Error: %m, %W%f(%l\\, %c) Hint: %m"

