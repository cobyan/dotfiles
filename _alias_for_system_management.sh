
alias getkey='gpg --keyserver keyserver.ubuntu.com --recv-keys $1 && gpg --export --armor $1 | sudo apt-key add - '


function mysql_dump_db(){
  db_user='root'
  db_pass='123'

  mysqldump -u$db_user -p$db_pass $1 > ./dump-$1-`date +"%Y-%m-%d_%r"`.sql
}

function mysql_drop_db() {
  db_user='root'
  db_pass='123'
  mysql -u$db_user -p$db_pass -e"DROP DATABASE $1"
}

function mysql_restore_db(){
  db_user='root'
  db_pass='123'
  mysql -u$db_user -p$db_pass $1 < $2
}

function mysql_dump_structure()
{
  mysqldump -Qc $@
}

alias mysql_drop='mysql_drop_db $1'
alias mysql_restore='mysql_restore_db $1 $2'
alias mysql_dump='mysql_dump_db $1'
alias mysql_dump_structure='mysql_dump_db_structure $@'


#!/bin/sh
#
# Script per la creazione di un file VirtualHost
# author: Marco Bianco - Alura snc
#
usage()
{
echo "Usage: `basename $0` -d percorso_document_root -s server_name [-o options]"
}

function make_apache_virtual_host() {
  A2ENSITE=/usr/sbin/a2ensite
  A2RELOAD="service apache2 reload"

  SITES_AVAILABLE_DIR="/etc/apache2/sites-available"
  ETC_HOSTS="/etc/hosts"

  DOCUMENT_ROOT=""
  SERVER_NAME=""
  OPTIONS="Indexes FollowSymLinks MultiViews"

  if [ $# -lt 4 ]; then
  usage
  exit
  fi

  while getopts ":d:s:o:" Option
  do
    case $Option in
      d )
  	if [ -d $OPTARG ]; then
  		DOCUMENT_ROOT="$OPTARG"
  	else
  		echo "DocumentRoot non valida. Esco."
  		usage
  		exit
  	fi;;
      s )
  	SERVER_NAME="$OPTARG";;
      o )
  	OPTIONS="$OPTARG";;
    esac
  done
  shift $(($OPTIND - 1))

  if [ "$DOCUMENT_ROOT" = "" ]; then
  	echo "DocumentRoot non puo' essere vuota. Esco"
  	usage
  	exit
  fi

  if [ "$SERVER_NAME" = "" ]; then
  	echo "ServerName non puo' essere vuota. Esco"
  	usage
  	exit
  fi

  echo "<VirtualHost *:80>
  	ServerAdmin webmaster@localhost
  	ServerName $SERVER_NAME
  	DocumentRoot $DOCUMENT_ROOT

  	<Directory $DOCUMENT_ROOT>
  		Options $OPTIONS
  		AllowOverride All
  		Order allow,deny
  		allow from all
  	</Directory>

  	ErrorLog /var/log/apache2/$SERVER_NAME-error.log
  	CustomLog /var/log/apache2/$SERVER_NAME-access.log combined

  	LogLevel warn
  </VirtualHost>" > "$SITES_AVAILABLE_DIR/$SERVER_NAME.conf"
  echo "VirtualHost creato in $SITES_AVAILABLE_DIR/$SERVER_NAME.conf"

  echo "Abilito il nuovo VirtualHost"
  $A2ENSITE $SERVER_NAME

  echo "Reload Apache"
  $A2RELOAD

  echo "Scrivo $ETC_HOSTS"
  echo "127.0.0.1 $SERVER_NAME" >> $ETC_HOSTS
  echo "OK"

  echo "Fine."
}

alias vh_start='make_apache_virtual_host -d $1 -s $2 -o $3'
