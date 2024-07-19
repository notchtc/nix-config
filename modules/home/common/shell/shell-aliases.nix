{
  sudo = "doas";
  e = "hx";
  se = "doas hx";
  cat = "bat";
  ls = "eza";
  ll = "eza -l";
  la = "eza -a";
  lla = "eza -la";
  rm = "trash-put";
  rme = "trash-empty -i";
  rml = "trash-list";
  rmr = "trash-restore";
  buildsite = "command rm -f docs/.files && ssg src docs \"chtc's site\" \"https://notchtc.github.io\"";
}
