{pkgs, ...}: {
  services.xserver = {
    enable = true;

    xkb = {
      layout = "pl";
      options = "caps:swapescape";
    };

    excludePackages = [pkgs.xterm];
  };
}
