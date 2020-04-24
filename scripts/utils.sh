function detect_os() {
    UNAME_A=$(uname -a)
    if grep -qi "Ubuntu" <<<$UNAME_A; then
        OS="Ubuntu"
    elif grep -qi "Manjaro" <<<$UNAME_A; then
        OS="Manjaro"
    elif grep -qi "Darwin" <<<$UNAME_A; then
        OS="OSX"
    else
        echo "unknown os: $UNAME_A"
        exit
    fi

    echo "detected os: $OS"
}
