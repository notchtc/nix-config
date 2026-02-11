{
  imports = [
    ./mounts.nix
    ./services.nix
  ];

  boot = {
    bcache.enable = false;
    supportedFilesystems = [ "zfs" ];
  };
}
