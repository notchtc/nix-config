{
  imports = [
    ./audio.nix
    ./fs
    ./tuned.nix
  ];

  hardware = {
    enableRedistributableFirmware = true;
    amdgpu.legacySupport.enable = true;
  };
}
