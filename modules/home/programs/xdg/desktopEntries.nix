{ lib, pkgs, ... }:
{
  xdg.desktopEntries = {
    "org.openmw.launcher" = {
      name = "OpenMW Launcher";
      genericName = "Role Playing Game";
      comment = "An engine replacement for The Elder Scrolls III: Morrowind";
      exec = lib.getExe (
        pkgs.writeShellScriptBin "openmw-launcher-wrapper" ''
          export OSG_VERTEX_BUFFER_HINT="VERTEX_BUFFER_OBJECT"

          ${lib.getExe' pkgs.gamemode "gamemoderun"} ${lib.getExe' pkgs.openmw "openmw-launcher"}
        ''
      );
      prefersNonDefaultGPU = true;
      icon = "openmw";
      type = "Application";
      categories = [
        "Game"
        "RolePlaying"
      ];
      settings.Keywords = "Morrowind;Reimplementation;Mods;esm;bsa";
    };
  };
}
