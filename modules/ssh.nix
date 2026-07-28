{
  config.modules.nixos.ssh = {
    services.openssh = {
      enable = true;

      openFirewall = true;
      startWhenNeeded = true;
      ports = [ 69 ];

      hostKeys = [
        {
          bits = 4096;
          path = "/var/lib/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          bits = 4096;
          path = "/var/lib/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };
  };
}
