return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "javascript",
        "json",
        "typescript",
        "yaml",
        "markdown",
        "markdown_inline",
        "query",
        "html",
        "bash",
        "regex",
        "css",
        "sql",
      })
    end,
  },
}
