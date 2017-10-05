# vim-codebeamer

Edit Codebeamer items from the comfort of Vim, your favorite text editor!

## Installation

vim-codebeamer requires Vim compiled with python support.

You likely have Python support, but you can check with `vim --version | grep +python`. MacVim comes with Python support.

Once you have these, use your favorite Vim plugin manager to install `croesch/vim-codebeamer`, or copy `plugin` and `ftdetect` into your `.vim` folder.

## Syntax highlight

Files ending with `.cb` are now highlighted with the Codebeamer's syntax. If you (temporarily) save Codebeamer (wiki) sites on disk and edit it in vim, choose `.cb` as ending.

## Usage

vim-codebeamer offers these commands:

#### :CBRead <item-number>

Loads the given item's description into a new buffer.

```
:CBRead 4711
```

#### :CBWrite (or just :w)

Writes the buffer back to the site.

## Configuration

If you don't specify these settings, vim-codebeamer will prompt you when you first run a vim-codebeamer command.

#### g:codebeamer_editor_url

The host of the site you're editing. For example `codebeamer.com`.

#### g:codebeamer_rest_prefix

The path to the REST API on that host - probably `/cb/rest/`

#### g:codebeamer_basicauth_username

Your account username.

#### g:codebeamer_basicauth_password

Your account password. I recommend putting the settings except password in your `.vimrc` and letting Vim ask for your password.

## Contributing

This plugin is currently quite simple (it just works for me). Contributions, suggestions, and feedback are all welcomed!

