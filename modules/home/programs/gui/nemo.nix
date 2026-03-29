{ lib, profiles, ... }:
{
  dconf.settings = lib.mkIf profiles.graphical.enable {
    "org/nemo/preferences" = {
      confirm-trash = true;
      default-sort-in-reverse-order = true;
      default-sort-order = "mtime";
      swap-trash-delete = true;
    };

    "org/nemo/preferences/menu-config" = {
      selection-menu-move-to-trash = false;
    };
  };
}
