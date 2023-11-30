if !exists("current_compiler")
    let current_compiler = "maven"
    lua vim.opt.makeprg = "mvn compile"
    set efm=[ERROR]\ %f:[%l\\,%c]\ %m
endif
