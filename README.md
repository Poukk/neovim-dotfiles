# neovim-dotfiles
Some basic Neovim configuration heavily based on [LazyVim](https://www.lazyvim.org/). Most of the keybindings and plugins remain the same.

## Installation
Make sure you have Neovim installed, and check the prerequisites for [lazy.nvim](https://github.com/folke/lazy.nvim). Then, install this configuration with:

```bash
git clone https://github.com/Poukk/neovim-dotfiles ~/.config/nvim
rm -rf ~/.config/nvim/.git
```

Optionally, you can clean up the repository by removing unnecessary files:

```
rm ~/.config/nvim/LICENSE
rm ~/.config/nvim/README.md
```

## For 42 Students
### 42 Header
Use the following command to configure the header for your 42 login:

```vim
:ConfigHeader
```

After configuration, you can insert the header with the keybinding `<F1>`.

### Norminette

A keybinding (`<Leader-n>`) is set that will show a [nui](https://github.com/MunifTanjim/nui.nvim) pop-up with the Norminette command, running it on the current file.

### Special Settings for `.c` and `.h` Files

- **Autoformatting is disabled** for `.c` and `.h` files to comply with 42's Norm requirements.
- Pressing `<Tab>` will insert 4 `\t` characters as required by the Norm.
