function pacss --description 'Search pacman sync databases without package descriptions'
    if test (count $argv) -eq 0
        echo "Usage: pacss <regex>..." >&2
        return 1
    end

    set -l color_opt auto
    if isatty stdout
        set color_opt always
    end

    pacman --color=$color_opt -Ss $argv | grep -v '^ '
end
