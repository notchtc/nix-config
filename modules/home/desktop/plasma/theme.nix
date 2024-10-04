{
  programs.plasma = {
    fonts = {
      general = {
        family = "sans-serif";
        pointSize = 10;
      };

      fixedWidth = {
        family = "monospace";
        pointSize = 10;
      };

      small = {
        family = "sans-serif";
        pointSize = 8;
      };

      toolbar = {
        family = "sans-serif";
        pointSize = 10;
      };

      menu = {
        family = "sans-serif";
        pointSize = 10;
      };

      windowTitle = {
        family = "sans-serif";
        pointSize = 10;
      };
    };

    workspace = {
      clickItemTo = "open";
      colorScheme = "BreezeDark";
      cursor = {
        theme = "phinger-cursors-dark";
        size = 24;
      };
      iconTheme = "Papirus-Dark";
      soundTheme = "ocean";
      splashScreen.theme = "none";
      theme = "breeze-dark";
      wallpaperPictureOfTheDay.provider = "simonstalenhag";
      wallpaperFillMode = "preserveAspectCrop";
    };
  };
}
