{ project, ... }:
{
  imports = [ "${project.inputs.agenix.result}/modules/age.nix" ];

  age = {
    identityPaths = [
      "/persist/ssh/ssh_host_ed25519_key"
      "/persist/ssh/ssh_host_rsa_key"
    ];

    secrets.chtc-password.file = ./chtc-password.age;
  };
}
