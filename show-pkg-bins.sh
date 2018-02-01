#!/bin/bash
# Show Package Binaries
# 2018 WeakNet Linux 8 CAFFEINE
# Douglas Berdeaux
# WeakNetLabs@Gmail.com
function usage {
	printf "\n  Show Package Binaries\n  2018 WeakNet Linux\n\nUsage: ./show-pkg-bins <package name> [buildfbmenu]\n\t\"buildfbmenu\" will build the syntax required for Fluxbox Menus\n\n"
	exit 1;
}
## Do we have the dependencies?
if [ $(which dpkg|wc -l) -lt 1 ] || [ $(which egrep|wc -l) -lt 1 ]
	then
		printf "[!] This application requires DPKG and EGREP to continue.\n"
		exit 1;
	fi
if [ "$1" != "" ]
	## A help request:
	then
		if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$1" == "" ]
			then
				usage
		fi
		## Not a help request:
		if [ "$2" != "" ]
			then
				if [ "$2" == "buildfbmenu" ]
					then
						for i in $(dpkg -L $1|egrep -i '/s?bin/'|sed 's/.*\///')
							do
								printf "[exec] ($i) {gnome-terminal -e \"sh -c \\\\\"$i;bash\\\\\"\"}\n"
							done
				fi
		else
			dpkg -L $1|egrep -i '/s?bin/'|sed 's/.*\///'
		fi
else
		usage
fi
