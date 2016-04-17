
if ( [ -e $PWD/.defaults.dist ] && [ ! -e $PWD/.defaults ] ); then
	tput bold
	tput setaf 1
	echo "✗ .defaults not found, perhaps you should create it by copying .defaults.dist"
	tput sgr0
else
	. $PWD/.defaults
	tput setaf 2
	echo "✓ Hello $SYSTEM_USERNAME"
	tput sgr0
fi

for file in ~/dotfiles/.{alias,functions,term}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
