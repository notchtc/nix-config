{ config }:
{
  config.homes."chtc:x86_64-linux" = {
    modules = [
      config.modules.home.common
      (import config.modules.home.desktop { inherit (config) inputs; })
    ];

    args = {
      project = config;
      system = "x86_64-linux";
    };
  };
}
