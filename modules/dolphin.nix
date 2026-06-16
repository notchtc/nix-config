{
  config.modules.home.dolphin =
    { lib, pkgs, ... }:
    let
      inherit (lib.attrsets) attrValues genAttrs;
      inherit (lib.trivial) const flip;
    in
    {
      packages = attrValues { inherit (pkgs.kdePackages) ark dolphin; };

      xdg.mime-apps.default-applications =
        flip genAttrs (const "org.kde.dolphin.desktop") [ "inode/directory" ]
        // flip genAttrs (const "org.kde.ark.desktop") [
          "application/x-tar"
          "application/x-compressed-tar"
          "application/x-bzip-compressed-tar"
          "application/x-bzip2-compressed-tar"
          "application/x-tarz"
          "application/x-xz-compressed-tar"
          "application/x-lzma-compressed-tar"
          "application/x-lzip-compressed-tar"
          "application/x-tzo"
          "application/x-lrzip-compressed-tar"
          "application/x-lz4-compressed-tar"
          "application/x-zstd-compressed-tar"
          "application/x-7z-compressed"

          "application/x-deb"
          "application/x-cd-image"
          "application/x-bcpio"
          "application/x-cpio"
          "application/x-cpio-compressed"
          "application/x-sv4cpio"
          "application/x-sv4crc"
          "application/x-rpm"
          "application/x-compress"
          "application/gzip"
          "application/x-bzip"
          "application/x-bzip2"
          "application/x-lzma"
          "application/x-xz"
          "application/zlib"
          "application/zstd"
          "application/x-lz4"
          "application/x-lzip"
          "application/x-lrzip"
          "application/x-lzop"
          "application/x-source-rpm"
          "application/vnd.debian.binary-package"
          "application/vnd.efi.iso"
          "application/vnd.ms-cab-compressed"
          "application/x-xar"
          "application/x-iso9660-appimage"
          "application/x-archive"

          "application/zip"
          "application/x-java-archive"

          "application/vnd.rar"

          "application/x-arj"
          "application/arj"

          "application/x-lha"
          "application/x-stuffit"
        ];
    };
}
