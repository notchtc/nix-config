{
  system ? throw "No platform provided",
  ...
}:
{
  imports = [
    ./autoaspm.nix
    ./bluetooth.nix
    ./cpu
    ./fs
    ./gpu
    ./laptop.nix
    ./media
  ];

  hardware.enableRedistributableFirmware = true;
  nixpkgs.hostPlatform = "${system}";
}
