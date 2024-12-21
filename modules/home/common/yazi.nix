{ inputs, pkgs, ... }:
{
  home.packages = [ pkgs.ripdrag ];

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";

    settings = {
      manager = {
        sort_by = "mtime";
        linemode = "size";
      };
      plugin.prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
      preview = {
        image_delay = 0;
        max_width = 1000;
        max_height = 1000;
      };
    };

    plugins = {
      chmod = "${inputs.yazi-plugins}/chmod.yazi";
      full-border = "${inputs.yazi-plugins}/full-border.yazi";
      git = "${inputs.yazi-plugins}/git.yazi";
      max-preview = "${inputs.yazi-plugins}/max-preview.yazi";
    };

    initLua = ''
      			require("full-border"):setup()
            require("git"):setup()
    '';

    keymap = {
      manager.prepend_keymap = [
        {
          on = "T";
          run = "plugin max-preview";
          desc = "Maximize or restore the preview pane";
        }
        {
          on = [
            "c"
            "m"
          ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
        {
          on = "!";
          run = "shell \"$SHELL\" --block ";
          desc = "Open shell here";
        }
        {
          on = "<C-n>";
          run = ''
            shell 'ripdrag "$@" -x 2>/dev/null &' --confirm
          '';
        }
      ];
    };
  };
}
