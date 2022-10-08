# PHP IDE (starter.lvim)

A great starting point for your `PHP` LunarVim journey!

# Configuration

Before you can start using everything you need to make sure that [mason]() has installed the necessary 
LSP Server and DAP adapter.
In this setup we use:
- [Intelephense](https://intelephense.com)
- [php-debug-adapter](https://github.com/xdebug/vscode-php-debug)
- [xdebug](https://xdebug.org/docs/install)

In order for these to work please run the following command: 
`:MasonInstall intelephense php-debug-adapter phpcs php-cs-fixer`

After this go into the folder that mason downloaded `php-debug-adapter` (normally would be in 
`$HOME/.local/share/nvim/mason/packages/php-debug-adapter/`), then after that go into the `extentension`
folder and run the following commands:
```shell
npm install
npm run build
```
