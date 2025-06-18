{ config }:
{
  config.homes."chtc:x86_64-linux" = {
    modules = [
      ./modules/desktop
      (import ./modules/schizofox { inherit (config.inputs) schizofox; })
    ];

    args = {
      project = config;
    };
  };
}
