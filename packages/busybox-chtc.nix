{
  config.packages.busybox-chtc = {
    systems = [ "x86_64-linux" ];

    package =
      { busybox, symlinkJoin }:
      let
        busybox' = busybox.override { enableAppletSymlinks = false; };
      in
      symlinkJoin {
        name = "busybox-chtc";
        inherit (busybox') version;
        paths = [ busybox' ];

        postBuild = ''
          tools=(
            "awk"
            "chattr"
            "cpio"
            "fuser"
            "grep"
            "gzip"
            "ifconfig"
            "killall"
            "lsof"
            "lspci"
            "lsusb"
            "nc"
            "netstat"
            "patch"
            "pkill"
            "ps"
            "sed"
            "tar"
            "time"
            "wget"
            "which"
            "whois"
            "xz"
          )

          for tool in "''${tools[@]}"; do
            ln -s "$out/bin/busybox" "$out/bin/$tool"
          done
        '';
      };
  };
}
