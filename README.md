# LiquidHaskell as a GHC Plugin

This repo demonstrates how to use [LiquidHaskell](https://github.com/ucsd-progsys/liquidhaskell) as a GHC plugin.

`lh-plugin-demo.cabal` shows 

- how to tell GHC to invoke the plugin
- how to specify the relevant LH wrapper packages as dependencies

`stack.yaml` shows

- how to point `stack` at the relevant LH repositories

**TODO** `cabal.project` shows

- how to point `cabal` to the relevant LH repositories

## GHCi Integration

By virtue of being a plugin, you now get LH errors in GHCi. Hence,
we get LH errors from 

- `ghcid` in the terminal, make sure to run with `ghcid -c "stack ghci"`

- all editor plugins based on `ghci` integration

![VS Code](vscode.png)

![Neovim](nvim.png)

![Emacs](emacs.png)

