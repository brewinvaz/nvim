# Neovim Setup Guide

## Pre-requisites

1.  Ensure that you have NVIM v0.10.1 or higher installed

```sh
nvim --version
```

## Setup

1. Clone github repo into `$HOME/.config/nvim`

## Other Setup

1. Mason - install the following tools manually `:Mason`

* Linters - flake8
* Formatters - black

2. Claude Code CLI Setup

```sh
npm install -g @anthropic-ai/claude-code
```

3. LLM CLI (optional)

```sh
brew install llm
```

##  TODO

- [ ] Evaluate neotab

##  Troubleshooting

1. Lazy plug-in installation may fail due to artifacts from other plugin managers or older versions of Neovim. Clear cache, state and other artifacts before you clone the repo.

```sh
rm -rf ~/.config/nvim/
rm -rf ~/.local/state/nvim/
rm -rf ~/.local/share/nvim/
rm -rf ~/.cache/nvim/
```
