#for file in ~/dotfiles/.{path,bash_prompt,exports,aliases,functions,extra}; do
for file in ~/dotfiles/.{defaults,alias,functions,term}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
