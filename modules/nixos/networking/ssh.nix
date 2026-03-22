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

      KexAlgorithms = [
        "mlkem768x25519-sha256"
        "sntrup761x25519-sha512"
        "sntrup761x25519-sha512@openssh.com"
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group-exchange-sha256"
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
