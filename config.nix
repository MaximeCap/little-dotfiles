{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "coding";
      paths = [
        fzf
        zoxide
        neovim
        fd
        ripgrep
        lazygit
        kubectl
        fnm
        tmux
        oh-my-posh
      ];
    };
  };
}
