{
  system ? throw "No platform provided",
  ...
}:
{
  imports = [
    ./cpu
    ./firmware.nix
    ./fs
    ./gpu
    ./media
    ./tuned.nix
  ];

  nixpkgs.hostPlatform = "${system}";
}
