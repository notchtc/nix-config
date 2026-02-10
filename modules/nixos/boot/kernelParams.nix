{
  boot.kernelParams = [
    "nohz_full=4-7"

    "noresume"
    "nohibernate"

    "rootflags=noatime"

    "systemd.show_status=auto"
    "rd.systemd.show_status=auto"

    "rd.udev.log_level=3"
    "udev.log_priority=3"

    "fbcon=nodefer"
  ];
}
