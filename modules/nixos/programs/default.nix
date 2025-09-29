{
  imports = [
    ./appimage.nix
    ./bash.nix
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
