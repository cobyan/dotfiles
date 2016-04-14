alias crop-images='mogrify -crop $1+$2+$3 ./$4*.png'

function take_multiple_screenshots() {
	frequency=${1:=2}

	#in Gnome
	#save_path="/home/marco/Immagini/Schermata del `date +"%Y-%m-%d %r"`.png"
	#in Ubuntu
	#save_path="/media/marco/HOME0/Immagini/Schermata del `date +"%Y-%m-%d %r"`.png"
	save_path=${2:="/media/marco/HOME0/Immagini/Schermata del `date +"%Y-%m-%d %r"`.png"}
	
	watch -n $frequency 'import -window root "$save_path"'
}

alias screenshot_rain='take_multiple_screenshots $1 $2'