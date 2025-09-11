{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.disko.result.nixosModules.disko
    ./preservation.nix
  ];

  environment.etc."lvm/lvm.conf".text = lib.mkIf config.services.lvm.enable ''
    devices {
      issue_discards = 1
    }
  '';

  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [ "/" ];
    };

    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };

  systemd.services.fstrim = {
    unitConfig.ConditionACPower = true;

    serviceConfig = {
      Nice = 19;
      IOSchedulingClass = "idle";
    };
  };
}
