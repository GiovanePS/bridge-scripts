#!/usr/bin/bash

if [ $EUID != 0 ]
then
	echo 'Execute como admin!'
	exit
fi

while [ 1 ]
do
	read -s -p "Digite uma senha para o anydesk: " password
	echo
	read -s -p "Confirme a senha: " confirm_password
	echo
	if [ "$password" == "$confirm_password" ]
	then
		break
	else
		echo 'As senhas não coincidem.'
	fi
done

echo $password | sudo anydesk --set-password

echo '
# GDM configuration storage
#
# See /usr/share/gdm/gdm.schemas for a list of available options.

[daemon]
# Uncomment the line below to force the login screen to use Xorg
WaylandEnable=false

# Enabling automatic login
AutomaticLoginEnable = true
AutomaticLogin = $USERNAME

# Enabling timed login
#  TimedLoginEnable = true
#  TimedLogin = user1
#  TimedLoginDelay = 10

[security]

[xdmcp]

[chooser]

[debug]
# Uncomment the line below to turn on debugging
# More verbose logs
# Additionally lets the X server dump core if it crashes
#Enable=true
' > /etc/gdm3/custom.conf

echo 'Operação concluída com êxito.'

killall -e anydesk
