{ config }:
{
  config.lib.constants.never = config.lib.modules.when false { };
}
