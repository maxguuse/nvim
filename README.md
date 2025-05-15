# My personal Neovim configuration
First of all, I do not guarantee any stability or convenience for anyone who decides to use this configuration. 
I designed it for my personal use and it can be changed or even fully rewritten at any given moment.

# Plugins
> You can see used plugins on [dotfyle](https://dotfyle.com/maxguuse/nvim).

# My own customization
In addition to those plugins I wrote my own simple wrappers around Neovims' builtin arglist and mksession to replicate bookmarks(yeah sessions can be used to store other useful stuff but I mainly use them to save arglists)
They are stored in `lua/core` directory. There's some docs about it for those of you who are mad enough to try my configuration.

### Arglist manipulations

Implemented as simple as possible:
- `<C-s>` -> Adds/removes current buffer to/from arglist
- `<C-l>` -> Go to next buffer in arglist (wraps around arglist and goes to last element if current buffer is first in the arglist)
- `<C-h>` -> Go to previous buffer in arglist (wraps around arglist and goes to first element if current buffer is last in the arglist) 
- I also added `require("core.arglist").info()` function that aggregates some useful info about arglist, I personally use it to put current buffer index in arglist on the statusline.

### Session management

Also implemented quite simple, so if you need some advanced session management more sophisticated plugin will be far more helpful:
- Using `require("core.util").GetProjectRoot()` it finds directory where it should place Session.vim file(usually directory containing `.git`)
- It autowrites and autoreads sessions to/from said directory
- Using `require("core.util").IsProtectedDir()` it avoids writing sessions to any directory not located in `vim.env.HOME` or directories located exactly one level below `vim.env.HOME`
