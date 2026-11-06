-- Plugins for reviewing changes in the worktree.
return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview: worktree changes" },
      { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Diffview: close" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: file history" },
      { "<leader>gR", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: repo history" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = "diff2_horizontal" },
        merge_tool = { layout = "diff3_mixed" },
      },
      file_panel = { listing_style = "tree", win_config = { position = "left", width = 35 } },
    },
  },

  -- file tree: show dotfiles and follow the current file, VSCode-like
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = { visible = true, hide_dotfiles = false, hide_gitignored = false },
        follow_current_file = { enabled = true },
      },
    },
  },
}
