function loop() {
	for i in {$1..$2}
	do
		wget `printf $3 $i`
	done
}

#alias wget_loop='loop $1 $2 $3'
