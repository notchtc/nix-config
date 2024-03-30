{ pkgs, ... }:
{
  services.ananicy = {
    enable = true;
    rulesProvider = pkgs.ananicy-cpp-rules;
  };
}
