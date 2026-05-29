{
  services.openssh = {
    enable = true;

    openFirewall = true;
    startWhenNeeded = true;
    ports = [ 69 ];

    settings = {
      PermitRootLogin = "no";

      AuthenticationMethods = "publickey";
      ChallengeResponseAuthentication = "no";
      UsePAM = false;

      ClientAliveCountMax = 5;
      ClientAliveInterval = 60;

      PerSourceMaxStartups = 1;
      PerSourceNetBlockSize = "32:128";

      Ciphers = [
        "aes256-gcm@openssh.com"
        "aes128-gcm@openssh.com"
        "aes256-ctr"
        "aes192-ctr"
        "aes128-ctr"
      ];

      Macs = [
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "umac-128-etm@openssh.com"
      ];
    };

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
}
