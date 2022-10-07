# starter.lvim: Scala

## Prerequisites

Scala's LSP, Metals, is not managed by Mason. Instead, you will need to follow the prerequisites on [nvim-metals](https://github.com/scalameta/nvim-metals)

## Setup

Once you have done the prerequisites, you should be able to execute `:MetalsInstall` to complete setup

## Overview

Outside of providing the basic IDE functionality (treesitter, autocomplete, diagnostics etc), some helpful binding for Metals are also setup:

- `<leader>Lr` - Restart build server
- `<leader>Li` - Display Metals Info
- `<leader>Lu` - Update Metals
- `<leader>Ld` - Run Metals Doctor

