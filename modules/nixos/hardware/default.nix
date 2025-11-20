{
  system ? throw "No platform provided",
  ...
}:
{
  imports = [
    ./autoaspm.nix
    ./cpu
    ./firmware.nix
    ./fs
    ./gpu
    ./laptop.nix
    ./media
  ];

  nixpkgs.hostPlatform = "${system}";
}
