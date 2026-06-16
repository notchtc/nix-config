{
  config.modules.nixos.virtualisation =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkIf;
    in
    {
      boot.kernelModules = [
        "vfio"
        "vfio_iommu_type1"
        "vfio_pci"
      ];

      virtualisation.libvirtd = {
        enable = true;
        spiceUSBRedirection.enable = mkIf config.xdg.portal.enable true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = false;
          swtpm.enable = true;
        };
      };

      programs.virt-manager.enable = mkIf config.xdg.portal.enable true;
    };
}
