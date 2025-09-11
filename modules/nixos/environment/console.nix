{ pkgs, ... }:
{
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v18n.psf.gz";
    keyMap = "pl";
  };
}
