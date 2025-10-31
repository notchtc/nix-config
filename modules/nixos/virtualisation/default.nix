{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mama.virtualisation;
  graphical = config.mama.profiles.graphical.enable;
in
{
  options.mama.virtualisation.enable = mkEnableOption "Enable virtualisation";

  config = mkIf cfg.enable {
    boot.kernelModules = [
      "vfio"
      "vfio_iommu_type1"
      "vfio_pci"
    ];

    programs.virt-manager.enable = mkIf graphical true;

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = false;
          swtpm.enable = true;
        };
      };
    };
  };
}
