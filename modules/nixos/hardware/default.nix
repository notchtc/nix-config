{
  system ? builtins.throw "No platform provided",
  ...
}:
{
  imports = [
    ./audio.nix
    ./fs
    ./tuned.nix
  ];

  nixpkgs.hostPlatform = "${system}";
  hardware = {
    enableRedistributableFirmware = true;
    amdgpu.legacySupport.enable = true;
  };
}
