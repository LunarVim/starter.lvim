# starter.lvim

A great starting point for your LunarVim journey!

starter.lvim is a collection of language specific LunarVim configs. Each config
is in its git own branch, if you want to contribute see the [guidelines](CONTRIBUTING.md).

## starter.lvim/master

This branch contains a config for a couple common languages

<details open>
  <summary>
    <strong>Contents</strong>
  </summary>

- [Supported languages](#supported-languages)
- [Requirements](#requirements)
- [Keybinds](#additional-keybinds)
</details>

## Supported languages

> **Note**
> formatting, diagnostics, completions should work out of the box for the languages
> below with the `LunarVim` configuration in this branch

- C/C++
- Typescript/Javascript
- python
- go
- rust
- bash
- html
- css
- json
- yaml
- toml
- dockerfile

## Requirements

Most of the language servers installation should happen automatically, but there
is a few that are manually configured and may requires manual installation.

Install them with the command below

```
:MasonInstall clangd rust_analyzer gopls
```

Binaries needed for diagnostics and formatting requires manual installation.
You need to install them using the builtin `mason.nvim` or with your favorite package
manager.

use the command below to install them with mason

```
:MasonInstall eslint_d prettier yamllint taplo goimports golangci-lint shellcheck shfmt hadolint flake8 black
```

### Additional keybinds

> **Note**
> Leader is mapped to <kbd>Space</kbd>

| Mode   | Key                                         | Action                                        |
| ------ | ------------------------------------------- | --------------------------------------------- |
| visual | <kbd>Leader</kbd>+<kbd>r</kbd>+<kbd>r</kbd> | Refactor selection                            |
| normal | <kbd>Leader</kbd>+<kbd>P</kbd>              | Project menu                                  |
| normal | <kbd>Leader</kbd>+<kbd>r</kbd>+<kbd>o</kbd> | Search and replace (open spectre panel)       |
| normal | <kbd>Leader</kbd>+<kbd>r</kbd>+<kbd>f</kbd> | Search and replace (search current file)      |
| normal | <kbd>Leader</kbd>+<kbd>r</kbd>+<kbd>c</kbd> | Search and replace (search word under cursor) |
| normal | <kbd>Leader</kbd>+<kbd>t</kbd>+<kbd>w</kbc> | Workspace diagnostics                         |
| normal | <kbd>Leader</kbd>+<kbd>t</kbd>+<kbd>d</kbc> | Document diagnostics                          |
| normal | <kbd>Leader</kbd>+<kbd>t</kbd>+<kbd>t</kbc> | LSP Type definitions                          |
| normal | <kbd>Leader</kbd>+<kbd>t</kbd>+<kbd>r</kbc> | LSP references                                |
| normal | <kbd>Leader</kbd>+<kbd>t</kbd>+<kbd>q</kbc> | Quickfix                                      |
