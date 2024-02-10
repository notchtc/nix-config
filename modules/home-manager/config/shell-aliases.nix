{
  sudo = "doas";
  e = "$EDITOR";
  se = "doas $EDITOR";
  cat = "bat --color always";
  rm = "trash-put";
  rme = "trash-empty";
  rml = "trash-list";
  rmr = "trash-restore";
  ".." = "cd ..";
  "..2" = "cd ../../";
  "..3" = "cd ../../../";
  "..4" = "cd ../../../../";
  "..5" = "cd ../../../../";
  buildsite = "command rm -f docs/.files && ssg src docs \"chtc's site\" \"https://notchtc.github.io\"";
}
