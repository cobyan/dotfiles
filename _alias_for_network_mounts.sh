# This file should not exists, as network mounts should live in /etc/fstab
# At least the password must be digited by the user
function mount_network_folder(){
  sudo mount -t cifs -o username=$2,password=$3 //$4/$1 /media/$2/$1
}

alias mount_network='mount_network_folder $1 $2 $3 $4'
