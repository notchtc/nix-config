let
  user-chtc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHtYPqw1VitvlRnvnO5skoX7vd+N6GET5XrFH4n3jNn3";
  host-dorothy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPHLvG8iW/LvGCX3uc3FvYRuJkQ8pqS4uNpbR2tBN1wf";
in
{
  "chtc-password.age".publicKeys = [
    user-chtc
    host-dorothy
  ];
}
