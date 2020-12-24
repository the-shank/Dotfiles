# abbreviations

# quick switch dirs
abbr -a dots 'cd ~/dotfiles/'
abbr -a .. 'cd ..' # up one
abbr -a ... 'cd ../..' # up two
abbr -a .... 'cd ../../..' # up three (that's enough)
abbr -a cdd 'cd -' # back

# quick edits to dotfiles
abbr -a aliases 'nvim ~/.config/fish/sourced/abbreviations.fish'

# general
abbr -a mkdirp 'mkdir -p' # auto nesting
abbr -a cpr 'cp -R' # recursive
abbr -a duh 'du -h' # list disk usage for all files in ./
abbr -a dush 'du -sh' # list total disk usage of ./
abbr -a chx 'chmod +x' # make it executable
abbr -a chR 'chmod -R' # recursive
abbr -a vim nvim
abbr -a cat bat
abbr -a lla 'll -a'
abbr -a lsa 'ls -a'
abbr -a less "less -MNi" # file info/position, line #'s, smart case
abbr -a conda-enable 'eval /home/shank/Applications/miniconda3/bin/conda "shell.fish" "hook" | source'

# redshift
abbr -a r0 'redshift -P -O 6500'
abbr -a r1 'redshift -P -O 6000'
abbr -a r2 'redshift -P -O 5500'
abbr -a r3 'redshift -P -O 5000'
abbr -a r4 'redshift -P -O 4500'
abbr -a r5 'redshift -P -O 4000'

# ripgrep
abbr -a rgi 'rg -i'

# fd
abbr -a fdh 'fd --hidden'

# youtube-dl
abbr -a y480 'youtube-dl -f "bestvideo[ext=webm][height<=480]+bestaudio[ext=webm]"'
abbr -a y480pl 'youtube-dl -f "bestvideo[ext=webm][height<=481]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s"'
abbr -a y720 'youtube-dl -f "bestvideo[ext=webm][height<=720]+bestaudio[ext=webm]"'
abbr -a y720pl 'youtube-dl -f "bestvideo[ext=webm][height<=720]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s"'
abbr -a y1080 'youtube-dl -f "bestvideo[ext=webm][height<=1080]+bestaudio[ext=webm]"'
abbr -a y1080pl 'youtube-dl -f "bestvideo[ext=webm][height<=1080]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s"'

# obsidian
abbr -a obs 'obsidian > /dev/null 2>&1 & && sleep 2s && disown (jobs -p)'
