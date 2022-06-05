function pyenv-enable --description "load pyenv"
    set -gx PYENV_SHELL fish
    source '/home/shank/.pyenv/libexec/../completions/pyenv.fish'
    command pyenv rehash 2>/dev/null
    function pyenv
      set command $argv[1]
      set -e argv[1]

      switch "$command"
      case activate deactivate rehash shell
        source (pyenv "sh-$command" $argv|psub)
      case '*'
        command pyenv "$command" $argv
      end
    end
end
