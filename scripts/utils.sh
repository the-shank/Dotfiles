function detect_os() {
    UNAME_A=$(uname -a)
    if grep -qi "Ubuntu" <<<$UNAME_A; then
        OS="ubuntu"
    elif grep -qi "Manjaro" <<<$UNAME_A; then
        OS="manjaro"
    elif grep -qi "Darwin" <<<$UNAME_A; then
        OS="darwin"
    else
        echo "unknown os: $UNAME_A"
        exit
    fi

    echo "detected os: $OS"
}
