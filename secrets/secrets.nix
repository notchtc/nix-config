let
  user-chtc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHtYPqw1VitvlRnvnO5skoX7vd+N6GET5XrFH4n3jNn3";
  host-dorothy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHg8mQglY4N0IeWxICZWfwiKdhPsQn08wCqrnBYehtco";
  host-elisabeth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWEyMA0V+QtEe6TErxdkX/Ho9H5iLUP9R+2I+QSq0eT";
in
{
  "chtc-password.age".publicKeys = [
    user-chtc
    host-dorothy
    host-elisabeth
  ];
}
