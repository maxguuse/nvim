return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  version = "v1.*",
  lazy = true,
  event = { "BufReadPost", "BufNewFile", "CmdlineEnter" },
  opts = {
    completion = {
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = MiniIcons.get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = MiniIcons.get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
    keymap = {
      preset = "none",
      ["<S-CR>"] = { "show", "accept" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

      ["<C-d>"] = { "show_documentation", "hide_documentation" },
      ["<C-k>"] = { "scroll_documentation_up" },
      ["<C-j>"] = { "scroll_documentation_down" },

      ["<M-s>"] = { "show_signature", "hide_signature" },
    },

    cmdline = {
      keymap = { preset = "inherit" },
      completion = { menu = { auto_show = true } },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    signature = { enabled = true },
  },
}
