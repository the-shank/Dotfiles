# abbreviations

# load private abbreviations
test -e ~/.abbr_private; and source ~/.abbr_private

# quick switch dirs
abbr -a .. 'cd ..'          # up one
abbr -a ... 'cd ../..'      # up two
abbr -a .... 'cd ../../..'  # up three (that's enough)
abbr -a cdd 'cd -'          # back to previous directory

# quick edits to dotfiles
abbr -a dots 'cd ~/dotfiles/ && nvim'
abbr -a aliases 'nvim ~/.config/fish/sourced/abbreviations.fish'
abbr -a nvinit 'nvim ~/dotfiles/config/nvim/init.vim'

# general
abbr -a mkp 'mkdir -p'      # auto nesting
abbr -a cpr 'cp -R'         # recursive
abbr -a duh 'du -h'         # list disk usage for all files in ./
abbr -a dush 'du -sh'       # list total disk usage of ./
abbr -a chx 'chmod +x'      # make it executable
abbr -a chR 'chmod -R'      # recursive
abbr -a mvv 'mv --verbose'  # mv verbose
abbr -a e nvim
abbr -a o open
abbr -a vim nvim
abbr -a cat bat
abbr -a l 'ls'
abbr -a ll 'ls -l'
abbr -a lll 'ls -la'
abbr -a lr 'ls -R'
abbr -a less "less -MNi"    # file info/position, line #'s, smart case
abbr -a conda-enable 'eval /home/shank/Applications/miniconda3/bin/conda "shell.fish" "hook" | source'

# redshift
abbr -a r0 'redshift -P -O 6500'
abbr -a r1 'redshift -P -O 6000'
abbr -a r2 'redshift -P -O 5500'
abbr -a r3 'redshift -P -O 5000'
abbr -a r4 'redshift -P -O 4500'
abbr -a r5 'redshift -P -O 4000'

# backlight
abbr -a bl 'sudo xbacklight -set'
abbr -a bl0 'sudo xbacklight -set 0'    # backlight = 0% (minimum)
abbr -a bl5 'sudo xbacklight -set 5'    # backlight = 5%
abbr -a bl10 'sudo xbacklight -set 10'  # backlight = 10%
abbr -a blinc 'sudo xbacklight -inc 2'
abbr -a bldec 'sudo xbacklight -dec 2'

# ripgrep
abbr -a rgi 'rg --ignore-case'
abbr -a rgil 'rg --ignore-case --files-with-matches'
abbr -a rgih 'rg --ignore-case --hidden'

# fd
if type -q fdfind
    if ! type -q fd
        alias fd=fdfind
    end
end
abbr -a fdh 'fd --hidden'
abbr -a fdi 'fd --ignore-case'
abbr -a fdih 'fd --ignore-case --hidden'

# youtube-dl
abbr -a y480 'youtube-dl -f "bestvideo[ext=webm][height<=480]+bestaudio[ext=webm]"'
abbr -a y480pl 'youtube-dl -f "bestvideo[ext=webm][height<=481]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist) (PL)/%(playlist_index)02d - %(title)s.%(ext)s"'
abbr -a y720 'youtube-dl -f "bestvideo[ext=webm][height<=720]+bestaudio[ext=webm]"'
abbr -a y720pl 'youtube-dl -f "bestvideo[ext=webm][height<=720]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist) (PL)/%(playlist_index)02d - %(title)s.%(ext)s"'
abbr -a y1080 'youtube-dl -f "bestvideo[ext=webm][height<=1080]+bestaudio[ext=webm]"'
abbr -a y1080pl 'youtube-dl -f "bestvideo[ext=webm][height<=1080]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist) (PL)/%(playlist_index)02d - %(title)s.%(ext)s"'

# delete nvim swp files
abbr -a rmswp "rm -f $HOME/.local/share/nvim/swap/*"

# rust
abbr -a c cargo
abbr -a ct 'cargo t'

# vagrant
abbr -a v vagrant
abbr -a vup 'vagrant up'
abbr -a vst 'vagrant status'
abbr -a vssh 'vagrant ssh'

# git
abbr -a gopn 'git open'
abbr -a ggone 'git branch -a -v | rg --ignore-case "\[gone\]" | awk \'{print $1}\' | xargs -t git branch -D'

# docker
abbr -a d docker
abbr -a dc 'docker container'
abbr -a di 'docker image'
abbr -a d-c 'docker-compose'

# python : flask-migrate - show current migration version info
abbr -a db-curr "python manage.py db show (python manage.py db current 2>/dev/null | tail -n1 | awk '{print \$1}')"
abbr -a db-hist "python manage.py db history"
abbr -a dbu "python manage.py db upgrade"
abbr -a dbd "python manage.py db downgrade"

# tree
abbr -a ta "tree -a"
abbr -a t1 "tree -L 1"
abbr -a t2 "tree -L 2"
abbr -a t3 "tree -L 3"

# dct
abbr -a db-bss-start "cd ~/code/dct/dct-dev-helpers; and docker-compose up --detach bss-db; and cd -"
abbr -a db-bss-stop "cd ~/code/dct/dct-dev-helpers; and docker-compose stop bss-db; and cd -"
abbr -a db-tp-start "cd ~/code/dct/dct-dev-helpers; and docker-compose up --detach tp-db; and cd -"
abbr -a db-tp-stop "cd ~/code/dct/dct-dev-helpers; and docker-compose stop tp-db; and cd -"
