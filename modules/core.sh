# Printar arquivo do logo
_PRINT() {
    local logo="$1"

    [[ ! -e "${logo}"  ]] && return 1
    while IFS= read -r line; do
        echo "$line"
    done < "$logo"
    return 0
}

_CTRLC() {
    echo "Jogo Encerrado!"
    killall ffplay &> /dev/null
    exit 0
}

# Efeito write usando pv
_WRITE() {
    local write="$@"
    echo "$write" # | pv -qL 18
    return 0
}

# Toca musica

_SOUND() {
    local song="$1"
    ffplay -nodisp "$song" &> /dev/null &
    export pid="$!"
    return 0
}

# MOdulo interativo para pressionar Enter
_ENTER() {
    read -p $'\e[37;41;1m\nPressione ENTER para continuar...\e[0m'
    return 0
}