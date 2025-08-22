{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ "${inputs.nix-mineral.result}/nix-mineral.nix" ];
  environment.systemPackages = [ pkgs.doas-sudo-shim ];

  nix-mineral = {
    enable = true;
    overrides = {
      compatibility = {
        allow-unsigned-modules = true;
        allow-ip-forward = true;
        no-lockdown = true;
      };
      performance.allow-smt = true;
      security = {
        disable-bluetooth-kmodules = true;
        disable-intelme-kmodules = true;
        lock-root = true;
      };
      software-choice = {
        doas-no-sudo = true;
        secure-chrony = true;
      };
    };
  };

  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = lib.mkDefault 0;
}
