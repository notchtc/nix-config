{
  nix.settings = {
    substituters = [
      "https://aseipp-nix-cache.freetls.fastly.net?priority=10"
      "https://cache.nixos.org?priority=20"
      "https://nix-community.cachix.org?priority=30"
      "https://cache.garnix.io?priority=40"
      "https://numtide.cachix.org?priority=50"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };
}
