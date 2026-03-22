{
  imports = [ ./chtc.nix ];

  services.userborn = {
    enable = true;
    passwordFilesLocation = "/var/lib/nixos";
  };
}
