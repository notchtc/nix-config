{ pkgs, ... }:
{
  hardware.graphics = {
    extraPackages = with pkgs; [ intel-media-driver ];
    extraPackages32 = with pkgs; [ intel-media-driver ];
  };
}
