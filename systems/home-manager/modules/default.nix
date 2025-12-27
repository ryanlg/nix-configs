{ inputs, ... }:
{
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
      ./neovim
      ./fonts.nix
<<<<<<< Updated upstream
      ./zsh.nix
=======
      ./zellij
>>>>>>> Stashed changes
    ];
}
