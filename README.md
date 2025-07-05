# My Dotfiles

This repository contains my personal dotfiles for various tools, managed with `fish` and a simple installation script.

## Installation

The installation is handled by an interactive `fish` script that lets you choose which configurations to install. It will back up any existing configurations to `~/.backup`.

### Prerequisites

- [Fish Shell](https://fishshell.com/)
- [Git](https://git-scm.com/)
- [Gum](https://github.com/charmbracelet/gum)
- `wget`

### Steps

1.  **Clone the repository:**

    ```sh
    git clone https://github.com/TeddyHuang-00/dotfiles.fish.git
    cd dotfiles.fish
    ```

2.  **Run the installer:**
    ```sh
    fish install.fish
    ```

The script will guide you through selecting the configurations you want to install.

## Included Configurations

You can choose to install any of the following configurations:

- **`fish`**: The core shell configuration.
- **`starship`**: A minimal, fast, and infinitely customizable prompt for any shell.
- **`tmux`**: A terminal multiplexer.
- **`nvim`**: Neovim editor configuration.
- **`jj`**: [Jujutsu](https://github.com/jj-vcs/jj), a powerful Git-compatible VCS.
- **`git`**: Basic Git configuration and ignores.
- **`delta`**: A viewer for `git` and `diff` output.
- **`bat`**: A `cat(1)` clone with syntax highlighting and Git integration.
- **`fastfetch`**: A fast, lightweight system information tool.
- **`tealdeer`**: A fast tldr client.
- **`ghostty`**: A modern, GPU-accelerated terminal emulator.
- **`zathura`**: A highly customizable and functional document viewer (Linux only).
- **`aerospace`**: A tiling window manager for macOS.

## Development

This repository uses `just` for running tasks.

- **`just format`**: Formats all `.fish` files using `fish_indent`.
