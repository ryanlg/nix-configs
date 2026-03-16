{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;

    settings = {
      highlight.enable = true;
      indent.enable = true;
    };

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rust
      python
      typescript
      tsx
      javascript
      c
      cpp
    ];
  };
}
