# LiquidHaskell as a GHC Plugin

This repo demonstrates how to use [LiquidHaskell](https://github.com/ucsd-progsys/liquidhaskell) as a GHC plugin.

`lh-plugin-demo.cabal` shows 

- how to tell GHC to invoke the plugin
- how to specify the relevant LH wrapper packages as dependencies

[stack.yaml](stack.yaml) shows

- how to point `stack` at the relevant LH repositories on **github**

[stack/stack-*.yaml](stack/) shows

- how to point `stack` at the relevant LH packages on **hackage**

[cabal.project.github](cabal.project.github) shows

- how to point `cabal` to the relevant LH repositories on **github**
- only works with ghc-9.8.1

No `cabal.project` file is needed for the releases of `liquidhaskell` in hackage.
`cabal-install` should pick the appropriate version for each compiler (supported GHCs:
9.2.8, 9.4.7, 9.6.3, 9.8.1)

## GHCi Integration

By virtue of being a plugin, you now get LH errors 

- when you (re)load in GHCi. 

- from all editor plugins based on `ghci` integration

### GHCID

VSCode running `ghcid` in a terminal 

![ghcid](ghcid.gif)

### VSCode 

VSCode with the `Simple GHC (Haskell) Integration` plugin 

![VS Code](vscode.gif)

Note that, by default, the extension uses Haddock, which is currently incompatible with LiquidHaskell. This repo includes custom .vscode settings to disable hadock, but you can also do it manually in the extension settings by removing ```:set -haddock``` from the ```Ghc Simple › Startup Commands: All``` section.

### Emacs

![Doom/Emacs with `dante`](emacs.gif)


### Vim

Vim/Neovim with `ALE` and the `stack-build` linter

![Vim/Neovim with `ALE` and the `stack-build` linter](vim.png)

## GHCID Integration

Additionally, [`ghcid`](https://github.com/ndmitchell/ghcid) produces LH errors on recompilation 

For `stack`-based projects, run with 

```
$ ghcid -c "stack ghci"
```

For `cabal`-based projects, run with 

```
$ ghcid -c "cabal v2-repl"
```

## Importing Specifications across Packages

The plugin also ensures that specifications written for one 
package are used when checking client packages. For an example, 
see the associated [lh-plugin-demo-client package](https://github.com/ucsd-progsys/lh-plugin-demo-client/).

