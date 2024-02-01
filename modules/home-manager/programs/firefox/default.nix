{
  package,
  profiles,
  arkenfox,
  ...
}: {
  programs.firefox = {
    enable = true;
    inherit package;
    inherit arkenfox;
    inherit profiles;
  };
}
