{
  config,
  lib,
  project,
  ...
}:
{
  imports = [
    project.inputs.disko.result.nixosModules.disko
    ./preservation.nix
  ];

  boot.kernelParams = [
    "luks.options=timeout=0"
    "rd.luks.options=timeout=0"
    "rootflags=x-systemd.device-timeout=0"
  ];

  environment.etc."lvm/lvm.conf".text = lib.mkIf config.services.lvm.enable ''
    devices {
      issue_discards = 1
    }
  '';

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  systemd.services.fstrim = {
    unitConfig.ConditionACPower = true;

    serviceConfig = {
      Nice = 19;
      IOSchedulingClass = "idle";
    };
  };
}
