{
  inputs,
  pkgs,
  system,
  ...
}:
{
  imports = [ inputs.run0-sudo-shim.result.nixosModules.default ];

  security = {
    wrappers.su.enable = false;
    run0-sudo-shim = {
      enable = true;
      package = pkgs.symlinkJoin {
        name = "sudo";
        paths = [ inputs.run0-sudo-shim.result.packages.${system}.default ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/sudo --add-flags "--run0-extra-arg=--background="
        '';
      };
    };
  };
}
