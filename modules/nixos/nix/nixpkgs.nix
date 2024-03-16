{ self, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;

    overlays = [ self.overlays.default ];
  };
}
