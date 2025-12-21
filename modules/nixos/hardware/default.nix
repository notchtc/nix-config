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
    ./laptop.nix
    ./media
  ];

  nixpkgs.hostPlatform = "${system}";
}
