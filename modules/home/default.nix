{ inputs, ... }:
{
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
      ./neovim
      ./fonts.nix
      ./zsh.nix
      ./programs.nix
    ];
}
