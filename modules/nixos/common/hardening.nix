{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ "${inputs.nix-mineral.result}/nix-mineral.nix" ];

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

  security = {
    protectKernelImage = true;
    unprivilegedUsernsClone = config.virtualisation.containers.enable;
  };

  environment.systemPackages = [ pkgs.doas-sudo-shim ];
  security.doas.extraRules = [ { groups = [ "wheel" ]; } ];
}
