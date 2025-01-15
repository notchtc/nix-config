{
  programs.plasma.configFile = {
    "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;

    "breezerc"."Common"."ShadowSize" = "ShadowNone";

    "kdeglobals"."General"."TerminalApplication" = "foot";
    "kdeglobals"."General"."TerminalService" = "org.codeberg.dnkl.foot.desktop";

    "kwalletrc"."Wallet"."Close When Idle" = true;
    "kwalletrc"."Wallet"."Close on Screensaver" = false;
    "kwalletrc"."Wallet"."Default Wallet" = "kdewallet";
    "kwalletrc"."Wallet"."Enabled" = true;
    "kwalletrc"."Wallet"."First Use" = false;
    "kwalletrc"."Wallet"."Idle Timeout" = 5;
    "kwalletrc"."Wallet"."Launch Manager" = false;
    "kwalletrc"."Wallet"."Leave Manager Open" = false;
    "kwalletrc"."Wallet"."Leave Open" = false;
    "kwalletrc"."Wallet"."Prompt on Open" = false;
    "kwalletrc"."Wallet"."Use One Wallet" = true;
    "kwalletrc"."org.freedesktop.secrets"."apiEnabled" = true;

    "kwinrc"."Compositing"."LatencyPolicy" = "Low";

    "plasmanotifyrc"."Notifications"."PopupPosition" = "TopRight";
  };
}
