{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "coding";
      paths = [
        neovim
        oh-my-posh
        fd
        ripgrep
        lazygit
        kubectl
        fnm
        tmux
      ];
    };
  };
}
