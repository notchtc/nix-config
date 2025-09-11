{
  imports = [
    ./bash.nix
    ./runners.nix
    ./zsh.nix
  ];

  programs = {
    nano.enable = false;
    vim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
