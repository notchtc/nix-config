{
  config.modules = {
    nixos.dolphin =
      { lib, pkgs, ... }:
      let
        inherit (lib.attrsets) attrValues;
        inherit (lib.modules) mkForce;
      in
      {
        services = {
          gvfs.enable = true;
          udisks2.enable = true;
        };

        xdg.portal = {
          extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
          config.niri."org.freedesktop.impl.portal.FileChooser" = mkForce [ "kde" ];
        };

        environment = {
          systemPackages = attrValues {
            inherit (pkgs.kdePackages)
              ark
              dolphin
              dolphin-plugins
              ffmpegthumbs
              kio
              kio-extras
              ;
          };

          # https://discourse.nixos.org/t/dolphin-does-not-have-mime-associations/48985/15
          etc."xdg/menus/applications.menu".text = ''
            <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
             "http://www.freedesktop.org/standards/menu-spec/1.0/menu.dtd">

            <Menu>
              <Name>Applications</Name>

              <!-- Search the default directories for .desktop files.
                   I.e. the /applications subdirectory of each entry in
                   $XDG_DATA_DIRS
              -->
              <DefaultAppDirs/>

              <!-- Menus and submenus can use localized names as well as icons
                   by referring to a .directory file. This configuration does
                   not use them, but add it to the search for future-proofing.
              -->
              <DefaultDirectoryDirs/>

              <!-- Add every .desktop entry in the search result to this
                   menu.
              -->
              <Include><All/></Include>

              <!-- List submenus before normal .desktop files in the menu. -->
              <DefaultLayout>
                <Merge type="menus"/>
                <Merge type="files" />
              </DefaultLayouts>

              <!-- Applications can add their own menu entries in
                   menus/applications-merged/. This will cause them to
                   be merged into this menu.
              -->
              <DefaultMergeDirs/>
            </Menu>
          '';
        };
      };

    home.dolphin =
      { lib, ... }:
      let
        inherit (lib.attrsets) genAttrs;
        inherit (lib.trivial) const flip;
      in
      {
        xdg = {
          config.files."kdeglobals".text = ''
            [General]
            TerminalApplication=xdg-terminal-exec
          '';

          mime-apps.default-applications =
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
      };
  };
}
