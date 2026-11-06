# Neovim config (LazyVim)

Based on the [LazyVim](https://www.lazyvim.org) starter. `deploy.sh` symlinks this dir to `~/.config/nvim`.
Needs nvim >= 0.11, git, rg, fd, lazygit, npm (for pyright), and a Nerd Font set in your terminal.
If nvim is older than 0.11, or lazy.nvim cannot be downloaded on first start (no git/network),
the config falls back to plain `~/.vimrc` settings and shows a warning.

Layout: `lua/config/*` holds options, keymaps and autocmds; `lua/plugins/*` holds extra plugins and overrides;
`lazyvim.json` lists the enabled extras (change them with `:LazyExtras`).

C++: clangd needs `compile_commands.json` in the project root or `build/`
(`cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON` or `bear -- make`).

## Review cheat sheet (`<leader>` = Space)

| Task | Key |
|---|---|
| Find file | `<leader><space>` / `<leader>ff` |
| Recent files | `<leader>fr` |
| Grep project | `<leader>/`, word under cursor `<leader>sw` |
| Symbols in file / workspace | `<leader>ss` / `<leader>sS` |
| Definition / references / hover | `gd` / `gr` / `K`, jump back `Ctrl-o` |
| Header <-> source (C++) | `<leader>ch` |
| File tree | `<leader>e` |
| Buffers (tabs) prev/next / close | `H` / `L` / `<leader>bd` |
| Worktree diff, side by side | `<leader>gv` (`Tab`/`S-Tab` next/prev file, `]c`/`[c` next/prev hunk), close `<leader>gV` |
| File / repo history | `<leader>gH` / `<leader>gR` |
| Git status picker | `<leader>gs` |
| Next/prev hunk, preview, reset | `]h` / `[h`, `<leader>ghp`, `<leader>ghr` |
| Blame line | `<leader>ghb` |
| Lazygit | `<leader>gg` |
| Diagnostics | `<leader>xx`, next `]d` |
| Split windows / move between | `<leader>-`, `<leader>\|` / `Ctrl-h/j/k/l` |
| All keys | press `<leader>` and wait, or `<leader>sk` |

Buffers reload automatically when files change on disk (every 2 s and on focus).
