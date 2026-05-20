let
  user-chtc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHtYPqw1VitvlRnvnO5skoX7vd+N6GET5XrFH4n3jNn3";
  host-elisabeth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWEyMA0V+QtEe6TErxdkX/Ho9H5iLUP9R+2I+QSq0eT";
in
{
  "chtc-password.age".publicKeys = [
    user-chtc
    host-elisabeth
  ];
}
