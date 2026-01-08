# abbreviations

# load private abbreviations
test -e ~/.abbr_private; and source ~/.abbr_private

# quick switch dirs
abbr -a -g .. 'cd ..' # up one
abbr -a -g ... 'cd ../..' # up two
abbr -a -g .... 'cd ../../..' # up three
abbr -a -g ..... 'cd ../../../..' # up four
abbr -a -g ...... 'cd ../../../../..' # up five
abbr -a -g cdd 'cd -' # back to previous directory

# quick edits to dotfiles
abbr -a -g dots 'cd ~/dotfiles/ && nvim'
abbr -a -g nva 'nvim ~/.config/fish/sourced/abbreviations.fish'

# general
abbr -a -g mkp 'mkdir -p' # auto nesting
abbr -a -g cp 'cp -av' # cp verbose mode by default
abbr -a -g cpr 'cp -Rav' # recursive
abbr -a -g rm 'rm -r' # recursive
abbr -a -g duh 'du -h' # list disk usage for all files in ./
abbr -a -g dush 'du -sh' # list total disk usage of ./
abbr -a -g chx 'chmod +x' # make it executable
abbr -a -g chR 'chmod -R' # recursive
abbr -a -g mv 'mv --interactive' # warn before overwriting files 
abbr -a -g mvv 'mv --interactive --verbose' # mv verbose
abbr -a -g cpwd 'echo (pwd) | xsel --input --clipboard' # copy current directory path
# abbr -a -g vim nvim
abbr -a -g e nvim
abbr -a -g o open
abbr -a -g cat bat
abbr -a -g l exa
abbr -a -g ls exa
abbr -a -g ll 'exa -l'
abbr -a -g lll 'exa -la'
abbr -a -g la 'exa -lah'
abbr -a -g lr 'ls -R'
abbr -a -g less "less -MNi"
abbr -a -g yr 'cal -y'
# abbr -a -g conda-enable 'eval /home/shank/Applications/miniconda3/bin/conda "shell.fish" "hook" | source'
abbr -a -g conda-enable 'eval /opt/miniconda3/bin/conda "shell.fish" "hook" | source'
abbr -a -g mo cal
abbr -a -g mo3 'cal -3'
# abbr -a -g diff 'diff --side-by-side'
# abbr -a -g diff difft
abbr -a -g locate 'locate -i'
abbr -a -g srf 'source /home/shank/.config/fish/config.fish'

# redshift
abbr -a -g r0 'redshift -P -O 6500'
abbr -a -g rs 'redshift -P -O 6300'
abbr -a -g r1 'redshift -P -O 6000'
abbr -a -g r2 'redshift -P -O 5500'
abbr -a -g r3 'redshift -P -O 5000'
abbr -a -g r4 'redshift -P -O 4500'
abbr -a -g r5 'redshift -P -O 4000'

# wlsunset (sway)
abbr -a -g ss0 'pkill wlsunset; wlsunset -T 6500 -t 6499 &; disown %1'
abbr -a -g sss 'pkill wlsunset; wlsunset -T 6300 -t 6299 &; disown %1'
abbr -a -g ss1 'pkill wlsunset; wlsunset -T 6000 -t 5999 &; disown %1'
abbr -a -g ss2 'pkill wlsunset; wlsunset -T 5500 -t 5499 &; disown %1'
abbr -a -g ss3 'pkill wlsunset; wlsunset -T 5000 -t 4999 &; disown %1'
abbr -a -g ss4 'pkill wlsunset; wlsunset -T 4500 -t 4499 &; disown %1'
abbr -a -g ss5 'pkill wlsunset; wlsunset -T 4000 -t 3999 &; disown %1'

# hyprsunset (hyprland)
abbr -a -g hs0 'pkill hyprsunset; sleep 0.2; hyprsunset --temperature 6500 &; disown %1'
abbr -a -g hss 'pkill hyprsunset; sleep 0.2; hyprsunset --temperature 6300 &; disown %1'
abbr -a -g hs1 'pkill hyprsunset; sleep 0.2; hyprsunset --temperature 6000 &; disown %1'
abbr -a -g hs2 'pkill hyprsunset; sleep 0.2; hyprsunset --temperature 5500 &; disown %1'
abbr -a -g hs3 'pkill hyprsunset; sleep 0.2; hyprsunset --temperature 5000 &; disown %1'
abbr -a -g hs4 'pkill hyprsunset; sleep 0.2; hyprsunset --temperature 4500 &; disown %1'
abbr -a -g hs5 'pkill hyprsunset; sleep 0.2; hyprsunset --temperature 4000 &; disown %1'

# gammastep (niri)
abbr -a -g gs0 'pkill gammastep; sleep 0.1; gammastep -O 6500 &; disown %1'
abbr -a -g gss 'pkill gammastep; sleep 0.1; gammastep -O 6300 &; disown %1'
abbr -a -g gs1 'pkill gammastep; sleep 0.1; gammastep -O 6000 &; disown %1'
abbr -a -g gs2 'pkill gammastep; sleep 0.1; gammastep -O 5500 &; disown %1'
abbr -a -g gs3 'pkill gammastep; sleep 0.1; gammastep -O 5000 &; disown %1'
abbr -a -g gs4 'pkill gammastep; sleep 0.1; gammastep -O 4500 &; disown %1'
abbr -a -g gs5 'pkill gammastep; sleep 0.1; gammastep -O 4000 &; disown %1'

# sway-scale
abbr -a -g ssc15 'sway-scale 1.5'
abbr -a -g ssc16 'sway-scale 1.6'

# kanshi-scale
abbr -a -g ksc40 'kanshi-scale 1.40'
abbr -a -g ksc33 'kanshi-scale 1.33'
abbr -a -g ksc30 'kanshi-scale 1.30'
abbr -a -g ksc25 'kanshi-scale 1.25'

# backlight
abbr -a -g bl 'sudo -E xbacklight -set'
abbr -a -g bl0 'sudo -E xbacklight -set 0' # backlight = 0% (minimum)
abbr -a -g bl1 'sudo -E xbacklight -set 1' # backlight = 1%
abbr -a -g bl2 'sudo -E xbacklight -set 2' # backlight = 2%
abbr -a -g bl3 'sudo -E xbacklight -set 3' # backlight = 3%
abbr -a -g bl5 'sudo -E xbacklight -set 5' # backlight = 5%
abbr -a -g bl7 'sudo -E xbacklight -set 7' # backlight = 7%
abbr -a -g bl8 'sudo -E xbacklight -set 8' # backlight = 8%
abbr -a -g bl9 'sudo -E xbacklight -set 9' # backlight = 9%
abbr -a -g bl10 'sudo -E xbacklight -set 10' # backlight = 10%
abbr -a -g blinc 'sudo -E xbacklight -inc 2'
abbr -a -g bldec 'sudo -E xbacklight -dec 2'

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
abbr -a -g fd 'fd --no-ignore'
abbr -a -g fdh 'fd --hidden --no-ignore'
abbr -a -g fdi 'fd --ignore-case --no-ignore'
abbr -a -g fdih 'fd --ignore-case --hidden --no-ignore'

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
abbr -a -g gopnp 'git open --print'
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
abbr -a -g lg lazygit
abbr -a -g gcb 'git checkout -b'
abbr -a -g gwt 'git worktree'

# docker
abbr -a -g dc 'docker container'
abbr -a -g dcl 'docker container ls'
abbr -a -g dcla 'docker container ls -a'
abbr -a -g dcrm 'docker container rm'
abbr -a -g dcst 'docker container start'
abbr -a -g dca 'docker container attach'
abbr -a -g di 'docker image'
abbr -a -g dil 'docker image ls'
abbr -a -g diu 'docker image pull'
abbr -a -g diua "docker image ls | tail --lines +2 | rg --ignore-case --invert-match \"(dbox|devc|<none>|aixcc|cve-2021)\" | awk '{printf \"%s:%s\n\",\$1,\$2}' | xargs -I{} bash -c 'echo \">> {} =============\"; docker image pull {}'"
abbr -a -g dsp 'docker system prune --filter "label!=no-prune"'
abbr -a -g dspy 'docker system prune --force --filter "label!=no-prune"'
abbr -a -g d-c docker-compose
# dev-container related
abbr -a -g dcs "docker container start -i (docker container ls -a | awk '{print \$NF}' | tail --lines +2 | fzf --prompt 'container> ')"
abbr -a -g dcnew '/home/shank/code/misc/dev-container/devc_new.sh'
abbr -a -g dcupd '/home/shank/code/misc/dev-container/devc_update.sh'

# distrobox
abbr -a -g dbe 'distrobox enter'
abbr -a -g dbl 'distrobox ls --no-stats'
abbr -a -g dbls 'distrobox ls --no-stats'
abbr -a -g dbll 'distrobox ls'
abbr -a -g dbrm 'distrobox rm'
abbr -a -g dbstop 'distrobox stop'
abbr -a -g dbc distrobox-create
abbr -a -g dbcl 'distrobox-create --clone'
abbr -a -g dbstopall "distrobox ls --no-stats | rg --ignore-case 'Up ' | awk '{print \$3}' | xargs -I{} distrobox stop -Y {}"
abbr -a -g xhostfix 'xhost +si:localuser:$USER'

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

# DCT
abbr -a -g db-bss-start "cd ~/code/dct/bss-data-layer; and docker-compose up --detach bss-db; and cd -"
abbr -a -g db-bss-stop "cd ~/code/dct/bss-data-layer; and docker-compose stop bss-db; and cd -"
abbr -a -g db-tp-start "cd ~/code/dct/tp-data-layer; and docker-compose up --detach tp-db; and cd -"
abbr -a -g db-tp-stop "cd ~/code/dct/tp-data-layer; and docker-compose stop tp-db; and cd -"

# stow
abbr -a -g restow "stow --no-folding --verbose -R"

# purdue
abbr -a -g ssh-purdue-cs "sshpass -f ~/.pca.private ssh sharm611@data.cs.purdue.edu"
abbr -a -g mount-purs3-workdisk "sshfs shank@purs3mango.ecn.purdue.edu:/workdisk/shank \
    /home/shank/sshfs/purdue/purs3_workdisk/shank \
    -o compression=yes \
    -o idmap=user \
    -o follow_symlinks \
    -o IdentityFile=/home/shank/.ssh/id_ed25519_arco"
abbr -a -g unmount-purs3-workdisk "fusermount -uz /home/shank/sshfs/purdue/purs3_workdisk/shank"

# file managers
# abbr -a -g r ranger
# abbr -a -g j joshuto

# cmake build type?
abbr -a -g build_type\? "bfs . -type f -name CMakeCache.txt | head -n1 | xargs -I{} rg --ignore-case cmake_build_type {}"

# pgrep should always be case insensitive
abbr -a -g pgrep "pgrep -i"

# https://github.com/joshmedeski/dotfiles/blob/main/mackup/.config/fish/config.fish
# abbr hd "history delete --exact --case-sensitive \'(history | fzf-tmux -p -m --reverse | cut -d \" \" -f 3-)\'"

# tmux
abbr -a -g tmud "~/.tmux/scripts/update_display.sh"

# tmux: without TERM env var explicitly set
abbr -a -g tml "tmux ls"
abbr -a -g tmn "tmux new -s"
abbr -a -g tmnd "tmux new -d -s"
abbr -a -g tms "tmux switch -t"
abbr -a -g tmsd "tmux switch -d -t"
abbr -a -g tma "tmux attach -d -t"
abbr -a -g tmrn "tmux rename-session -t"
abbr -a -g tmd "tmux detach"

# common object utitilies
abbr -a -g dsyms "llvm-readelf --dyn-syms --demangle"

# package managers: commonly used invocations
abbr -a -g ali "apt list --installed"
abbr -a -g pli "pacman --query --quiet"
abbr -a -g xli "xbps-query --list-pkgs"

# misc
abbr -a -g asanopts "ASAN_OPTIONS=\"detect_leaks=0:abort_on_error=1:symbolize=1:handle_abort=1\""
abbr -a -g dpi\? "cat $HOME/.xsession | rg --ignore-case dpi="
abbr -a -g d120 "dpi.sh 120"
abbr -a -g d114 "dpi.sh 114"
abbr -a -g nf neofetch
abbr -a -g jb "just build"
abbr -a -g procs "procs --color disable"
abbr -a -g procsl "procs --theme light"
abbr -a -g prl "procs --theme light"
abbr -a -g procsd "procs --theme dark"
abbr -a -g prd "procs --theme dark"
abbr -a -g nicer "nice -n 10"

# keyboard
# - increase repeat rate
# - map caps to escape
abbr -a -g fk "xset r rate 250 50; setxkbmap -option caps:escape"

# Applications
abbr -a -g zj zellij
# abbr -a -g j just

# pacman/paru aliases
abbr -a -g owns\? "paru --query --owns" # <path/to/file>
abbr -a -g provides\? "paru --files" # <path/to/file>
abbr -a -g paru "paru --review"

# ssh -> useful in docker containers
abbr -a -g fixssh "rm -r /tmp/ssh-agent.socket; ssh-agent -a /tmp/ssh-agent.socket >/dev/null; ssh-add"

# memory status
abbr -a -g memst 'zswap-stats; printf "\n"; free -mt'

# nix
abbr -a -g renix 'ls $HOME/.nix-profile/share/applications/ | xargs -I{} unlink $HOME/.local/share/applications/{}; ln -s $HOME/.nix-profile/share/applications/* $HOME/.local/share/applications'

# archlinux
abbr -a -g pkgs "pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

# fish themes
abbr -a -g ft-tokyo-day "fish_config theme choose TokyoNight\ Day && yes | fish_config theme save TokyoNight\ Day"
abbr -a -g ft-tokyo-storm "fish_config theme choose TokyoNight\ Storm && yes | fish_config theme save TokyoNight\ Storm"
abbr -a -g ft-b16-eighties "fish_config theme choose Base16\ Eighties && yes | fish_config theme save Base16\ Eighties"
abbr -a -g ft-b16-dark "fish_config theme choose Base16\ Default\ Dark && yes | fish_config theme save Base16\ Default\ Dark"
abbr -a -g ft-solarized-light "fish_config theme choose Solarized\ Light && yes | fish_config theme save Solarized\ Light"
abbr -a -g ft-mono-light "fish_config theme choose Mono\ Lace && yes | fish_config theme save Mono\ Lace"

# cmake - throw errors for undefined variables
# abbr -a -g cmake "cmake -Werror=dev --warn-uninitialized"

# send slack notificaiton
abbr -a -g ssln "send_slack_notification.sh"
abbr -a -g slnd "send_slack_notification.sh done"

# processes that can take a lot of cpu
abbr -a -g cargo "nice cargo"
abbr -a -g make "nice make"
abbr -a -g cmake "nice cmake"
abbr -a -g ninja "nice ninja"
