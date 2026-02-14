{
  inputs,
  lib,
  profiles,
  system,
  ...
}:
{
  programs.vicinae = lib.mkIf profiles.graphical.enable {
    enable = true;
    systemd.enable = true;

    settings = {
      close_on_focus_loss = true;
      font.normal.size = 11;

      providers = {
        "@dagimg-dot/vicinae-extension-wifi-commander-0".preferences.network-cli-tool = "iwctl";

        browser-extension.enabled = false;
        core.entrypoints = {
          open-config-file.enabled = false;
          open-default-config.enabled = false;
          sponsor.enabled = false;
          store.enabled = false;
        };
        developer.enabled = false;
        power.entrypoints.hibernate.enabled = false;
        raycast-compat.enabled = false;
        wm.enabled = false;
      };
    };

    extensions = builtins.attrValues {
      inherit (inputs.vicinae-extensions.result.packages.${system})
        aria2-manager
        bluetooth
        niri
        nix
        wifi-commander
        ;
    };
  };
}
