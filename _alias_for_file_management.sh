

function move_files() {
  ${1:='/home/marco/Immagini'}
  ${2:='Schermata*'}
  ${3:='/media/marco/3XMount/myfreewebcams.com/Zh'}
  find $1 -name $2 -print0 | xargs -0 mv -t $3
}

alias mf='move_files $1 $2 $3'
alias transfer='mount_network $1 $2 $3 $4;move_files $5 $6 $7'

function rsync_folders() {
  ${1:='/home/marco/Immagini'}
  ${2:='/media/marco/3XMount/myfreewebcams.com/Zh'}
  rsync -av --delete $1 $2
}

alias sync_folders='rsync_folders $1 $2'
