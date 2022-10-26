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
abbr -a nvinit 'nvim ~/.config/nvim/init.vim'

# general
abbr -a mkp 'mkdir -p'      # auto nesting
abbr -a cp 'cp -av'         # cp verbose mode by default
abbr -a cpr 'cp -Rav'       # recursive
# abbr -a rm 'rm -Irf'        # recursive and force
if type -q trash
    abbr -a rm trash
end
if type -q trach-cli
    abbr -a rm trash-cli
end
abbr -a duh 'du -h'         # list disk usage for all files in ./
abbr -a dush 'du -sh'       # list total disk usage of ./
abbr -a chx 'chmod +x'      # make it executable
abbr -a chR 'chmod -R'      # recursive
abbr -a mv 'mv --interactive'               # warn before overwriting files 
abbr -a mvv 'mv --interactive --verbose'    # mv verbose
abbr -a cpwd 'echo (pwd) | xsel --input --clipboard'    # copy current directory path
abbr -a e nvim
abbr -a o open
abbr -a vim nvim
abbr -a cat bat
abbr -a l 'exa'
abbr -a ll 'exa -l'
abbr -a lll 'exa -la'
abbr -a la 'exa -lah'
abbr -a lr 'ls -R'
abbr -a less "less -MNi"
abbr -a yr 'cal -y'
# abbr -a conda-enable 'eval /home/shank/Applications/miniconda3/bin/conda "shell.fish" "hook" | source'
abbr -a conda-enable 'eval /opt/miniconda3/bin/conda "shell.fish" "hook" | source'
abbr -a mo 'cal -m'

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
abbr -a gst 'git status'
abbr -a gcl 'git clone'
abbr -a gd 'git diff'
abbr -a gl 'git pull'
abbr -a gp 'git push'
abbr -a gc 'git commit'
abbr -a gcm 'git commit -m'
abbr -a gco 'git checkout'
abbr -a gr 'git remote'
abbr -a grv 'git remote --verbose'
abbr -a gb 'git branch'
abbr -a gba 'git branch -a'
abbr -a ga 'git add'
abbr -a grh 'git reset HEAD'
abbr -a grhh 'git reset HEAD --hard'
abbr -a lg 'lazygit'

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

# python : flake8 checks for the files modified in the current PR
abbr -a chk-flake8 "git diff --name-only master... | xargs -t flake8"

# tree
abbr -a ta "tree -a"
abbr -a t1 "tree -L 1"
abbr -a t2 "tree -L 2"
abbr -a t3 "tree -L 3"

# dct
abbr -a db-bss-start "cd ~/code/dct/bss-data-layer; and docker-compose up --detach bss-db; and cd -"
abbr -a db-bss-stop "cd ~/code/dct/bss-data-layer; and docker-compose stop bss-db; and cd -"
abbr -a db-tp-start "cd ~/code/dct/tp-data-layer; and docker-compose up --detach tp-db; and cd -"
abbr -a db-tp-stop "cd ~/code/dct/tp-data-layer; and docker-compose stop tp-db; and cd -"

# stow
abbr -a restow "stow --no-folding --verbose -R"

# purdue
abbr -a ssh-purdue-cs "sshpass -f ~/.pca.private ssh sharm611@data.cs.purdue.edu"
abbr -a mnt-purs3-workdisk "sshfs shank@purs3mango.ecn.purdue.edu:/workdisk \
    /home/shank/sshfs/purdue/purs3_workdisk \
    -o compression=yes \
    -o idmap=user \
    -o follow_symlinks \
    -o IdentityFile=/home/shank/.ssh/id_ed25519_arco"
abbr -a unmount-purs3-workdisk "fusermount -uz /home/shank/sshfs/purdue/purs3_workdisk"

# nnn - file manager
abbr -a n nnn

# cmake build type?
abbr -a build_type "rg --ignore-case cmake_build_type CMakeCache.txt"

# pgrep should always be case insensitive
abbr -a pgrep "pgrep -i"

# https://github.com/joshmedeski/dotfiles/blob/main/mackup/.config/fish/config.fish
# abbr hd "history delete --exact --case-sensitive \'(history | fzf-tmux -p -m --reverse | cut -d \" \" -f 3-)\'"

# tmux
abbr -a tml "tmux ls"
abbr -a tmn "tmux new -s"
abbr -a tmnd "tmux new -d -s"
abbr -a tms "tmux switch -t"
abbr -a tmsd "tmux switch -d -t"
abbr -a tma "tmux attach -d -t"
abbr -a tmd "tmux detach"
