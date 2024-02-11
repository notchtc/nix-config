{
  e = "$EDITOR";
  se = "doas $EDITOR";
  cat = "bat --color always";
  mv = "mv -i";
  cp = "cp -i";
  rm = "trash-put -i";
  rme = "trash-empty -i";
  rml = "trash-list";
  rmr = "trash-restore";
  buildsite = "command rm -f docs/.files && ssg src docs \"chtc's site\" \"https://notchtc.github.io\"";
}
