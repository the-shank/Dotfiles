# abbreviations

# load private abbreviations
test -e ~/.abbr_private; and source ~/.abbr_private

# quick switch dirs
abbr -a -g .. 'cd ..'          # up one
abbr -a -g ... 'cd ../..'      # up two
abbr -a -g .... 'cd ../../..'  # up three (that's enough)
abbr -a -g cdd 'cd -'          # back to previous directory

# quick edits to dotfiles
abbr -a -g dots 'cd ~/dotfiles/ && nvim'
abbr -a -g aliases 'nvim ~/.config/fish/sourced/abbreviations.fish'
abbr -a -g nvinit 'nvim ~/.config/nvim/init.vim'

# general
abbr -a -g mkp 'mkdir -p'      # auto nesting
abbr -a -g cp 'cp -av'         # cp verbose mode by default
abbr -a -g cpr 'cp -Rav'       # recursive
# abbr -a -g rm 'rm -Irf'        # recursive and force
if type -q trash
    abbr -a -g rm trash
end
if type -q trach-cli
    abbr -a -g rm trash-cli
end
abbr -a -g duh 'du -h'         # list disk usage for all files in ./
abbr -a -g dush 'du -sh'       # list total disk usage of ./
abbr -a -g chx 'chmod +x'      # make it executable
abbr -a -g chR 'chmod -R'      # recursive
abbr -a -g mv 'mv --interactive'               # warn before overwriting files 
abbr -a -g mvv 'mv --interactive --verbose'    # mv verbose
abbr -a -g cpwd 'echo (pwd) | xsel --input --clipboard'    # copy current directory path
abbr -a -g e nvim
abbr -a -g o open
abbr -a -g vim nvim
abbr -a -g cat bat
abbr -a -g l 'exa'
abbr -a -g ll 'exa -l'
abbr -a -g lll 'exa -la'
abbr -a -g la 'exa -lah'
abbr -a -g lr 'ls -R'
abbr -a -g less "less -MNi"
abbr -a -g yr 'cal -y'
# abbr -a -g conda-enable 'eval /home/shank/Applications/miniconda3/bin/conda "shell.fish" "hook" | source'
abbr -a -g conda-enable 'eval /opt/miniconda3/bin/conda "shell.fish" "hook" | source'
abbr -a -g mo 'cal -m'

# redshift
abbr -a -g r0 'redshift -P -O 6500'
abbr -a -g r1 'redshift -P -O 6000'
abbr -a -g r2 'redshift -P -O 5500'
abbr -a -g r3 'redshift -P -O 5000'
abbr -a -g r4 'redshift -P -O 4500'
abbr -a -g r5 'redshift -P -O 4000'

# backlight
abbr -a -g bl 'sudo xbacklight -set'
abbr -a -g bl0 'sudo xbacklight -set 0'    # backlight = 0% (minimum)
abbr -a -g bl5 'sudo xbacklight -set 5'    # backlight = 5%
abbr -a -g bl10 'sudo xbacklight -set 10'  # backlight = 10%
abbr -a -g blinc 'sudo xbacklight -inc 2'
abbr -a -g bldec 'sudo xbacklight -dec 2'

# ripgrep
abbr -a -g rgi 'rg --ignore-case'
abbr -a -g rgil 'rg --ignore-case --files-with-matches'
abbr -a -g rgih 'rg --ignore-case --hidden'

# fd
if type -q fdfind
    if ! type -q fd
        alias fd=fdfind
    end
end
abbr -a -g fdh 'fd --hidden'
abbr -a -g fdi 'fd --ignore-case'
abbr -a -g fdih 'fd --ignore-case --hidden'

# youtube-dl
abbr -a -g y480 'youtube-dl -f "bestvideo[ext=webm][height<=480]+bestaudio[ext=webm]"'
abbr -a -g y480pl 'youtube-dl -f "bestvideo[ext=webm][height<=481]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist) (PL)/%(playlist_index)02d - %(title)s.%(ext)s"'
abbr -a -g y720 'youtube-dl -f "bestvideo[ext=webm][height<=720]+bestaudio[ext=webm]"'
abbr -a -g y720pl 'youtube-dl -f "bestvideo[ext=webm][height<=720]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist) (PL)/%(playlist_index)02d - %(title)s.%(ext)s"'
abbr -a -g y1080 'youtube-dl -f "bestvideo[ext=webm][height<=1080]+bestaudio[ext=webm]"'
abbr -a -g y1080pl 'youtube-dl -f "bestvideo[ext=webm][height<=1080]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist) (PL)/%(playlist_index)02d - %(title)s.%(ext)s"'

# delete nvim swp files
abbr -a -g rmswp "rm -f $HOME/.local/share/nvim/swap/*"

# rust
abbr -a -g c cargo
abbr -a -g ct 'cargo t'

# vagrant
abbr -a -g v vagrant
abbr -a -g vup 'vagrant up'
abbr -a -g vst 'vagrant status'
abbr -a -g vssh 'vagrant ssh'

# git
abbr -a -g gopn 'git open'
abbr -a -g ggone 'git branch -a -v | rg --ignore-case "\[gone\]" | awk \'{print $1}\' | xargs -t git branch -D'
abbr -a -g gst 'git status'
abbr -a -g gcl 'git clone'
abbr -a -g gd 'git diff'
abbr -a -g gl 'git pull'
abbr -a -g gp 'git push'
abbr -a -g gc 'git commit'
abbr -a -g gcm 'git commit -m'
abbr -a -g gco 'git checkout'
abbr -a -g gr 'git remote'
abbr -a -g grv 'git remote --verbose'
abbr -a -g gb 'git branch'
abbr -a -g gba 'git branch -a'
abbr -a -g ga 'git add'
abbr -a -g grh 'git reset HEAD'
abbr -a -g grhh 'git reset HEAD --hard'
abbr -a -g lg 'lazygit'

# docker
abbr -a -g d docker
abbr -a -g dc 'docker container'
abbr -a -g di 'docker image'
abbr -a -g d-c 'docker-compose'

# python : flask-migrate - show current migration version info
abbr -a -g db-curr "python manage.py db show (python manage.py db current 2>/dev/null | tail -n1 | awk '{print \$1}')"
abbr -a -g db-hist "python manage.py db history"
abbr -a -g dbu "python manage.py db upgrade"
abbr -a -g dbd "python manage.py db downgrade"

# python : flake8 checks for the files modified in the current PR
abbr -a -g chk-flake8 "git diff --name-only master... | xargs -t flake8"

# tree
abbr -a -g ta "tree -a"
abbr -a -g t1 "tree -L 1"
abbr -a -g t2 "tree -L 2"
abbr -a -g t3 "tree -L 3"

# dct
abbr -a -g db-bss-start "cd ~/code/dct/bss-data-layer; and docker-compose up --detach bss-db; and cd -"
abbr -a -g db-bss-stop "cd ~/code/dct/bss-data-layer; and docker-compose stop bss-db; and cd -"
abbr -a -g db-tp-start "cd ~/code/dct/tp-data-layer; and docker-compose up --detach tp-db; and cd -"
abbr -a -g db-tp-stop "cd ~/code/dct/tp-data-layer; and docker-compose stop tp-db; and cd -"

# stow
abbr -a -g restow "stow --no-folding --verbose -R"

# purdue
abbr -a -g ssh-purdue-cs "sshpass -f ~/.pca.private ssh sharm611@data.cs.purdue.edu"
abbr -a -g mnt-purs3-workdisk "sshfs shank@purs3mango.ecn.purdue.edu:/workdisk \
    /home/shank/sshfs/purdue/purs3_workdisk \
    -o compression=yes \
    -o idmap=user \
    -o follow_symlinks \
    -o IdentityFile=/home/shank/.ssh/id_ed25519_arco"
abbr -a -g unmount-purs3-workdisk "fusermount -uz /home/shank/sshfs/purdue/purs3_workdisk"

# file managers
abbr -a -g n nnn
abbr -a -g r ranger

# cmake build type?
abbr -a -g build_type "rg --ignore-case cmake_build_type CMakeCache.txt"

# pgrep should always be case insensitive
abbr -a -g pgrep "pgrep -i"

# https://github.com/joshmedeski/dotfiles/blob/main/mackup/.config/fish/config.fish
# abbr hd "history delete --exact --case-sensitive \'(history | fzf-tmux -p -m --reverse | cut -d \" \" -f 3-)\'"

# tmux
abbr -a -g tml "tmux ls"
abbr -a -g tmn "tmux new -s"
abbr -a -g tmnd "tmux new -d -s"
abbr -a -g tms "tmux switch -t"
abbr -a -g tmsd "tmux switch -d -t"
abbr -a -g tma "tmux attach -d -t"
abbr -a -g tmd "tmux detach"
