# Neovim Configuration

My personal Neovim configuration, built with [LazyVim](https://github.com/LazyVim/LazyVim) and customized for a modern full-stack development workflow.

This configuration is primarily focused on **TypeScript, JavaScript, Node.js, SQL, and web development**, while also providing a comfortable environment for working with other languages.

## ✨ Features

- 💤 [LazyVim](https://github.com/LazyVim/LazyVim) as the base configuration
- 🌳 Treesitter for syntax highlighting and code-aware features
- 🧠 LSP support through Mason and `vtsls`
- 🔍 Fast file and text searching
- 🧪 Neotest with Vitest support
- 🌐 TypeScript / JavaScript development
- 🗄️ SQL development
- 🐳 Docker tooling
- 🌿 Git integration with Lazygit
- 🤖 GitHub Copilot
- 🎨 Tokyo Night Storm
- 🔤 JetBrainsMono Nerd Font
- ⚡ Lazy-loaded plugins through `lazy.nvim`

## 🛠️ Languages & Tools

Currently configured for:

- TypeScript
- JavaScript
- TSX / JSX
- HTML
- CSS
- SQL
- JSON
- YAML
- Markdown
- Bash
- Lua
- Docker

## 📁 Structure

```text
~/.config/nvim
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins
│       ├── lsp.lua
│       ├── test.lua
│       ├── treesitter.lua
│       └── ...
└── stylua.toml
