{
  lib,
  inputs,
  osConfig,
  system,
  ...
}:
{
  programs.vicinae = lib.mkIf osConfig.mama.profiles.graphical.enable {
    enable = true;
    systemd.enable = true;

    settings = {
      close_on_focus_loss = true;
      font.normal.size = 11;

      browser-extension.enabled = false;
      core.entrypoints = {
        sponsor.enabled = false;
        store.enabled = false;
      };
      developer.enabled = false;
      raycast-compat.enabled = false;
      wm.enabled = false;

      providers = {
        "@dagimg-dot/vicinae-extension-wifi-commander-0".preferences.network-cli-tool = "iwctl";
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
