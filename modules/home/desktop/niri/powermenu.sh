#!/bin/sh

SELECTION="$(printf "Lock\nSuspend\nLog out\nShutdown\nReboot\nReboot to UEFI\n" | fuzzel --dmenu -l 6)"

case $SELECTION in
	"Lock")
		loginctl lock-session;;
	"Suspend")
		systemctl suspend;;
	"Log out")
		niri msg action quit -s;;
	"Shutdown")
		systemctl poweroff;;
	"Reboot")
		systemctl reboot;;
	"Reboot to UEFI")
		systemctl reboot --firmware-setup;;
esac
