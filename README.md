# 🚀 Sir-George's Neovim Configuration

A modern, feature-rich Neovim configuration built on top of [LazyVim](https://lazyvim.github.io/), designed for productivity and enhanced development experience.

## 📖 About

This configuration represents my journey from Packer to Lazy.nvim, refined into a stable and extensible setup. It combines the power of LazyVim with carefully selected plugins and custom keymaps to boost productivity across multiple programming languages and workflows.

## ✨ Key Features

### 🤖 AI-Powered Development
- **Magenta.nvim**: Advanced AI coding assistant with Claude Sonnet 4 and GPT-5 support
- **GitHub Copilot**: Code completion and chat integration
- **Dual AI profiles**: Switch between different models for various tasks

### 🎨 Beautiful Interface
- **Custom ASCII Dashboard**: Personalized startup screen
- **Rose Pine Theme**: Elegant color scheme
- **Mini-animate**: Smooth animations for better UX

### 🔧 Development Tools
- **Language Support**: Go debugging, Java development, Tailwind CSS
- **Git Integration**: Fugitive for advanced Git operations
- **Undo Management**: Visual undo tree with UndoTree
- **Jupyter Integration**: Jupynium for notebook development

### ⚡ Productivity Enhancements
- **Telescope**: Fuzzy finder integration
- **Harpoon2**: Quick file navigation
- **Mini-snippets**: Code snippet management
- **Surround**: Text object manipulation

## 🚀 Installation

### Prerequisites
- Neovim >= 0.9.0
- Git
- Node.js and npm (for Magenta.nvim)
- A [Nerd Font](https://www.nerdfonts.com/)

### Quick Start

1. **Backup existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/yourusername/nvim-config ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```
   
   Lazy.nvim will automatically install all plugins on first run.

4. **Set up Magenta.nvim**:
   After installation, run `:checkhealth magenta` to verify setup.

## 🗝️ Key Mappings

### AI Assistant (Magenta)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>mt` | Normal | Toggle Magenta sidebar |
| `<leader>mc` | Normal | New chat |
| `<leader>ma` | Visual | Add selection to chat |
| `<leader>me` | Visual | Explain code |
| `<leader>mf` | Visual | Fix code issues |
| `<leader>mr` | Visual | Refactor code |
| `<leader>mp` | Normal | Select AI profile |

### Copilot Chat
| Key | Mode | Action |
|-----|------|--------|
| `<leader>aa` | Normal/Visual | Toggle Copilot chat |
| `<leader>aq` | Normal/Visual | Quick chat |
| `<leader>ap` | Normal/Visual | Prompt actions |
| `<leader>ax` | Normal/Visual | Clear chat |

### Custom Productivity
| Key | Mode | Action |
|-----|------|--------|
| `J` | Visual | Move selected lines down |
| `K` | Visual | Move selected lines up |
| `<leader>dt` | Normal | Duplicate current line |
| `<leader>Ca` | Normal | Copy entire file to clipboard |
| `<leader>f` | Normal | Format current file |
| `<leader>hf` | Normal | Format entire file |

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lazy-lock.json          # Plugin lock file
├── lazyvim.json            # LazyVim extras configuration
├── lua/
│   ├── config/
│   │   ├── autocmds.lua    # Auto commands
│   │   ├── keymaps.lua     # Custom key mappings
│   │   ├── lazy.lua        # Plugin manager setup
│   │   └── options.lua     # Neovim options
│   └── plugins/
│       ├── alpha.lua       # Dashboard configuration
│       ├── copilot-chat.lua # Copilot chat setup
│       ├── magent.lua      # Magenta AI assistant
│       ├── rose_pine.lua   # Theme configuration
│       └── [other plugins...]
```

## 🎯 LazyVim Extras Enabled

- `lazyvim.plugins.extras.ai.copilot`
- `lazyvim.plugins.extras.ai.copilot-chat`
- `lazyvim.plugins.extras.coding.mini-snippets`
- `lazyvim.plugins.extras.coding.mini-surround`
- `lazyvim.plugins.extras.dap.core`
- `lazyvim.plugins.extras.editor.harpoon2`
- `lazyvim.plugins.extras.editor.telescope`
- `lazyvim.plugins.extras.lang.tailwind`

## 🔌 Notable Plugins

### AI & Code Enhancement
- **[magenta.nvim](https://github.com/dlants/magenta.nvim)**: Advanced AI coding assistant
- **[copilot.lua](https://github.com/zbirenbaum/copilot.lua)**: GitHub Copilot integration
- **[CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)**: Interactive AI chat

### UI & Experience
- **[alpha-nvim](https://github.com/goolord/alpha-nvim)**: Custom dashboard
- **[rose-pine](https://github.com/rose-pine/neovim)**: Beautiful theme
- **[mini.animate](https://github.com/echasnovski/mini.animate)**: Smooth animations

### Development Tools
- **[vim-fugitive](https://github.com/tpope/vim-fugitive)**: Git integration
- **[undotree](https://github.com/mbbill/undotree)**: Visual undo history
- **[nvim-surround](https://github.com/kylechui/nvim-surround)**: Text manipulation

## 🛠️ Customization

### Adding New Plugins
1. Create a new file in `lua/plugins/`
2. Add the plugin specification
3. Import it in `lua/config/lazy.lua`

### Modifying Keymaps
Edit `lua/config/keymaps.lua` to add or modify key mappings.

### Changing Themes
Modify the imports in `lua/config/lazy.lua` to switch themes.

## 🤝 Contributing

Feel free to explore, learn from, and suggest improvements to this configuration. If you find something useful or have ideas for enhancements, don't hesitate to share!

## 📚 Resources

- [LazyVim Documentation](https://lazyvim.github.io/)
- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Plugin Manager](https://github.com/folke/lazy.nvim)

---

*This configuration is continuously evolving. Check back for updates and new features!*
