# 🛠️Dotfiles

The following repository contains all of the custom settings terminal tooling or plugins I use.

- [Neovim](https://neovim.io/)
- [Wezterm](https://wezfurlong.org/wezterm/)
- [Starship](https://starship.rs/)

## Installation

If you are looking to install the repository and setup the configuration in your linux machine do the following

1. Clone the repository in the `root directory` using the following command:

```bash
git clone https://github.com/mahibulhaque/dotfiles.git
```

2. In order to symlink the config files or folders to your `~/.config` directorymake sure to install [GNU Stow](https://www.gnu.org/software/stow/) using the following command:

```bash
brew install stow
```

or if you are on `Linux` run the following:

```bash
sudo apt install stow
```

3. You can individually symlink any directory present in the repo by running the following:

```bash
stow <folder-name>
```

For example, running `stow nvim` will symlink the `~/.config/nvim` directory to `dotfiles/nvim/.config/nvim`.
