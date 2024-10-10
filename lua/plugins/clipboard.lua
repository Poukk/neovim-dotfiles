return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- Use system clipboard
      clipboard = {
        -- Explicitly set the clipboard to "unnamedplus" for system clipboard
        register = "unnamedplus",
        -- Optional: Add custom copy/paste mappings
        mappings = {
          -- Clipboard copy (visual mode)
          ["<leader>y"] = '"+y',
          -- Clipboard paste (normal mode)
          ["<leader>p"] = '"+p',
        },
      },
    },
  },
}
