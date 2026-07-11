# Sir-George Neovim — Cheatsheet

> Pull this up anytime with `<leader>D` or `:Docs`. Press `q` to close.
> Leader key = `Space`. Search every keymap live with `<leader>sk`.

Built on [LazyVim](https://lazyvim.org). Theme: rose-pine (transparent).

## Layout of this config

| Path | What lives there |
|---|---|
| `lua/config/lazy.lua` | Bootstraps lazy.nvim, imports LazyVim + everything in `lua/plugins/` |
| `lua/config/options.lua` | Editor options |
| `lua/config/keymaps.lua` | Custom keymaps + the `:Docs` command |
| `lua/plugins/*.lua` | One file per plugin/concern — every file is auto-loaded |
| `lazyvim.json` | LazyVim extras (Go, Java, Tailwind, DAP, Telescope, Harpoon, …) |

Plugin management: `<leader>l` opens Lazy (`:Lazy sync` to update), `:LazyExtras`
manages extras, `:Mason` manages LSP servers/formatters/debuggers.

## Claude Code (the AI pair-programming loop)

You own **design** and **review**; Claude fills in the middle. Every prompt below
is prefilled but **unsubmitted** in Claude's input — you review, edit, and press
Enter yourself. Claude's edits come back as diffs you accept or reject.

| Key | Mode | Behavior |
|---|---|---|
| `<leader>aa` / `Ctrl+,` | n | Toggle the Claude terminal (right split) |
| `<leader>af` | n | Focus the Claude terminal |
| `<leader>ar` | n | `claude --resume` (pick an old session) |
| `<leader>ac` | n | `claude --continue` (jump back into the last session) |
| `<leader>ab` | n | Add the current buffer to Claude's context |
| `<leader>as` | v | Send the selection to Claude as context |
| `<leader>ai` | v | **Implement selected interface** — see workflow below |
| `<leader>at` | v | **Write tests for selection** — won't touch the implementation; reports bugs instead of silently fixing them |
| `<leader>ad` | n | **Fix diagnostic on current line** — sends the exact LSP error, demands a minimal fix, no ignore-comments |
| `<leader>aR` | n | **Review uncommitted changes** — Claude runs `git diff` and returns severity-ranked findings; review-only |
| `<leader>ay` | n | Accept the diff Claude proposed |
| `<leader>an` | n | Deny the diff Claude proposed |

### The interface-first workflow

1. Write the function **signature + doc comment** yourself — inputs, outputs,
   error semantics. This is the spec.
2. Select it (`V`) and hit `<leader>ai`. An input pops up for optional notes
   (`Enter` = skip, `Esc` = cancel).
3. Claude's input is prefilled with your interface + strict scope rules
   (keep signature/docs verbatim, match file style, change nothing else).
   Press Enter to send.
4. Review the diff: `<leader>ay` accept / `<leader>an` deny.
5. `<leader>at` on the same selection for tests → run them yourself →
   `<leader>aR` before you commit.

## Custom editing keymaps

| Key | Mode | Behavior |
|---|---|---|
| `J` / `K` | v | Move selected lines down / up (re-indents as it goes) |
| `<leader>dt` | n | Duplicate current line — ⚠ after a debug session loads, DAP remaps this to Terminate |
| `<leader>Ca` | n | Copy the whole file to the system clipboard |
| `<leader>hf` | n | Format file via LSP (LazyVim's `<leader>cf` does the same) |
| `:SortImports` | — | Run `import-sort` on the current file |
| `<leader>D` / `:Docs` | n | This cheatsheet |

## LazyVim essentials (daily drivers)

### Find & search
| Key | Behavior |
|---|---|
| `<leader><space>` / `<leader>ff` | Find files |
| `<leader>/` | Grep the project |
| `<leader>,` | Switch buffers |
| `<leader>fr` | Recent files |
| `<leader>e` | File explorer |
| `<leader>sk` | Search all keymaps (when you forget anything here) |

### Code & LSP
| Key | Behavior |
|---|---|
| `gd` / `gr` / `gI` | Go to definition / references / implementation |
| `K` | Hover docs |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cf` | Format |
| `]d` / `[d` | Next / previous diagnostic (then `<leader>ad` to have Claude fix it) |
| `<leader>xx` | Diagnostics list (Trouble) |

### Git
| Key | Behavior |
|---|---|
| `<leader>gg` | LazyGit |
| `<leader>gb` | Blame current line |
| `]h` / `[h` | Next / previous hunk |
| `:Git <cmd>` | Fugitive (e.g. `:Git blame`, `:Git log`) |

### Buffers, windows, terminal
| Key | Behavior |
|---|---|
| `Shift+h` / `Shift+l` | Previous / next buffer |
| `<leader>bd` | Close buffer |
| `Ctrl+h/j/k/l` | Move between windows |
| `<leader>-` / `<leader>\|` | Horizontal / vertical split |
| `Ctrl+/` | Toggle terminal |

### Harpoon (pin your working set of files)
| Key | Behavior |
|---|---|
| `<leader>H` | Pin current file |
| `<leader>h` | Quick menu of pinned files |
| `<leader>1`–`5` | Jump straight to pin 1–5 |

### Debugging (DAP — Go and Java configured via extras)
| Key | Behavior |
|---|---|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue / start |
| `<leader>di` / `<leader>do` | Step into / over |
| `<leader>du` | Toggle DAP UI |
| `:DapTerminate` | Stop the session |

## Java & Spring Boot

Open any `.java` file in a Maven/Gradle project and two language servers attach
automatically: **jdtls** (completion, navigation, refactoring, debug, test) and
**spring-boot** (live Spring symbols, `application.properties`/`yaml` completion
& validation). Lombok is preconfigured. JDK comes from `JAVA_HOME` (sdkman).

| Key | Mode | Behavior (Java buffers) |
|---|---|---|
| `<leader>co` | n | Organize imports |
| `<leader>cxv` / `cxc` | n, v | Extract variable / constant |
| `<leader>cxm` | v | Extract method |
| `<leader>cgs` / `cgS` | n | Go to super / subjects |
| `<leader>tt` | n | Run all tests in class (debugger-backed) |
| `<leader>tr` | n | Run nearest test method |
| `<leader>tT` | n | Pick a test to run |

Debugging uses the same DAP keys as everywhere (`<leader>db` breakpoint,
`<leader>dc` continue — main classes are auto-discovered). For Spring Boot,
run the app with `<leader>dc` or from a terminal: `mvn spring-boot:run`.

## Extras & tools

- **Jupynium** (Jupyter in Neovim): `:JupyniumStartAndAttachToServer`, then edit
  `.ju.py` files with `# %%` cells. Server runs on port 8890.
- **Markdown preview**: `:MarkdownPreviewToggle` (opens in the browser).
- **Undo history**: `:UndotreeToggle`.
- Plugin updates are checked automatically but silently — run `:Lazy` to see
  and apply pending updates.
