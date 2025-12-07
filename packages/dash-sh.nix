{
  config.packages.dash-sh = {
    systems = [ "x86_64-linux" ];

    package =
      { dash, symlinkJoin }:
      symlinkJoin {
        name = "dash-sh";
        inherit (dash) version;
        paths = [ dash ];

        postBuild = ''
          ln -s "$out/bin/dash" "$out/bin/sh"
        '';
      };
  };
}
