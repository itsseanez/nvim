-- Pad every line in a block to the same width so the dashboard centers it evenly
local function block(lines)
  local w = 0
  for _, l in ipairs(lines) do
    w = math.max(w, vim.fn.strdisplaywidth(l))
  end
  for i, l in ipairs(lines) do
    lines[i] = l .. string.rep(" ", w - vim.fn.strdisplaywidth(l))
  end
  return table.concat(lines, "\n")
end

local banner = block({
  "███████╗███████╗ █████╗ ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
  "██╔════╝██╔════╝██╔══██╗████╗  ██║██║   ██║██║████╗ ████║",
  "███████╗█████╗  ███████║██╔██╗ ██║██║   ██║██║██╔████╔██║",
  "╚════██║██╔══╝  ██╔══██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  "███████║███████╗██║  ██║██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
})

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = banner,
      },
      sections = {
        -- Animated crown (runs crown.sh from your nvim config folder)
        {
          section = "terminal",
          cmd = "bash " .. vim.fn.stdpath("config") .. "/crown.sh",
          height = 7,
          padding = 1,
          ttl = 0, -- don't cache: always run live
        },
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
