{
  config.modules.home.ghostty = {
    xdg.config.files."xdg-terminals.list".text = ''
      com.mitchellh.ghostty.desktop
    '';

    rum.programs.ghostty = {
      enable = true;

      settings = {
        cursor-style = "bar";
        font-family = "Atkinson Hyperlegible Mono";
        theme = "Gruvbox Dark Hard";
        window-padding-x = 3;
        window-padding-y = 3;
        window-theme = "system";

        mouse-hide-while-typing = true;
        quit-after-last-window-closed = false;

        scrollback-limit = 100 * 1024 * 1024;
        shell-integration = "none";
      };
    };
  };
}
