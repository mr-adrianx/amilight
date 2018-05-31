#!/bin/sh

###
#####		Amilight.sh ver: Beta
###
#### AppLamp, MiLight, LimitlessLED, Applight, Applamp, LEDme, dekolight, iLight, Easybulb

# Sources:
# https://gist.github.com/AppLamp-API/5576325
# http://iqjar.com
# http://limitlessled.com/dev

# Edit these params:
controller_ip="192.168.3.11"
controller_port="8899"



postcmd=""

case $1 in
	rgb)
		postcmd="\x55"
		case $2 in
			on)	cmd="\x22";;
			off)	cmd="\x21";;
			bup)	cmd="\x23";;
			bdown)	cmd="\x24";;
			sup)	cmd="\x25";;
			sdown)	cmd="\x26";;
			esup)	cmd="\x27";;
			esdown)	cmd="\x28";;


			#needs checking, lacking half of the colors.
			blue)		cmd="\x20\x10";;
			lightblue)	cmd="\x20\x20";;
			green1)		cmd="\x20\x30";;
			lightgreen1)	cmd="\x20\x40";;
			green)		cmd="\x20\x50";;
			lightgreen)	cmd="\x20\x60";;
			2green)		cmd="\x20\x70";;
			light2green)	cmd="\x20\x80";;
			yellow)		cmd="\x20\x90";;

			esac
		;;

	wwcw)
		postcmd="\x00"
		case $2 in
			on)	cmd="\x35";;
			off)	cmd="\x39";;
			bup)	cmd="\x3c";;
			bdown)	cmd="\x34";;
			nl)	cmd="\xb9";;
			fl)	cmd="\xb5";;
			ww)	cmd="\x3e";;
			cw)	cmd="\x3f";;


			1)
				case $3 in
					on)	cmd="\x38";;
					off)	cmd="\x3b";;
					fl)	cmd="\xb8";;
					nl)	cmd="\xb9";;
				esac
			;;

			2)
				case $3 in
					on)	cmd="\x2d";;
					off)	cmd="\x33";;
					fl)	cmd="\xbd";;
					nl)	cmd="\xb3";;
				esac
			;;

			3)
				case $3 in
					on)	cmd="\x37";;
					off)	cmd="\x3a";;
					fl)	cmd="\xb7";;
					nl)	cmd="\xba";;
				esac
			;;
			
			4)
				case $3 in
					on)	cmd="\x32";;
					off)	cmd="\x36";;
					fl)	cmd="\xb2";;
					nl)	cmd="\xb6";;
				esac
			;;

			esac
		;;
	
	rgbw)
		postcmd="\x00"
		case $2 in
			on)	cmd="\x42";;
			off)	cmd="\x41";;
			bup)	cmd="\x3c";;
			bdown)	cmd="\x34";;

			#funke ikke, kansje pga. den e i fargemodus
			white)	cmd="\xc2";;
			ww)	cmd="\x3e";;
			cw)	cmd="\x3f";;


			1)
				case $3 in
					on)	cmd="\x45";;
					off)	cmd="\x46";;
					white)	cmd="\xc5";;
				esac
			;;

			2)
				case $3 in
					on)	cmd="\x47";;
					off)	cmd="\x48";;
					white)	cmd="\xc7";;
				esac
			;;

			3)
				case $3 in
					on)	cmd="\x49";;
					off)	cmd="\x4A";;
					white)	cmd="\xc9";;
				esac
			;;
			4)
				case $3 in
					on)	cmd="\x4B";;
					off)	cmd="\x4C";;
					white)	cmd="\xCB";;
				esac
			;;
			esac
		;;

	*)
		echo "no match found" $1 $2 $3
		echo 
		echo 
		echo "Supports: RGB - RGBW - WWCW"
		echo " "
		echo 
		echo "RGB (no groups)."
		echo "- on, off, bup, bdown, esup, esdown, color"
		echo 
		echo "RGBW (no groups)"
		echo "- on, off, bup, bdown, white, ww, wc"
		echo .
		echo "WWCW (groups)"
		echo "- on, off, bup, bdown, nl, fl, ww,cw"
		echo 
		echo " "
		echo "syntax examples:"
		echo "- amilight.sh wwcd 3 ww (wwcw bulbs in group nr3)"
		echo "- amilight.sh rgbw bdown (all wwcw bulbs)"
		echo "- amilight.sh" 
		;;
esac
echo -n -e $cmd$postcmd | nc -uxc $controller_ip $controller_port >/dev/null 2>&1
