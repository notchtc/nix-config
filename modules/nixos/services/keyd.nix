{
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        capslock = "overload(control, esc)";
        esc = "capslock";
        "leftshift+leftmeta+f23" = "rightcontrol";
      };
    };
  };

  systemd.services.keyd.restartIfChanged = false;
}
