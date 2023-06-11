#!/bin/bash
#================================HEADER================================|
#Autor
# Jan Cordeiro <jancordeiro@protonmail.com>
#
#Game
# Dragon
#======================================================================|

#=========================| VARIAVEIS   |
#=========================| BIBLIOTECAS |
source modulos/core.sh #Biblioteca Principal

#=========================| TESTES      |

#=========================| INICIO      |
trap _CTRLC int # Trapando CTRL + C
_SOUND "som/menu.mp3" # Musica do menu
while true; do
clear
_PRINT "logo/logo.txt" || { echo "Logo não encontrado"; exit 1 ;}
    inc='0'
    for printme in 'Novo Profile' 'Carregar Profile' 'Ajuda' 'Sair'; do
        inc=$(($inc + 1 ))
        echo "[$inc]$printme"
    done
    read -p $'\n> ' choice
    case $choice in
        1) # Registrando novo profile
	    while true; do
	        read -p "Digite um nome de usuário: " user
		user="${user,,}" # Toda entrada em minusculo
		if [[ -e "profile/${user}.profile" ]]; then
		    echo "Profile já existe."
		    continue
		fi
	        if [[ -z "$user" ]]; then
		    echo "Você precisa digitar um nome."
		    continue
		else
		    break
	        fi
	    done
	    # Enviando Profile
	    cat <<EOF > "profile/${user}.profile"
# NAO EDITE.
name="$user"
room='0'
history='1'
EOF
	    echo "Profile ${user} Criado com sucesso."
	    sleep 2.5s
	;;
        2) # Carregar profile
	    pushd "profile" &>/dev/null
	    while true; do
	    inc='0'
	    for x in *; do
		if [[ "$x" = '*' ]]; then
		    echo "Nenhum profile encontrado!"
		    key_profile='off'
		    sleep 2.5s
		fi
		x="${x/.profile}" # Cortando .profile
		inc="$(($inc + 1))"
		the_profile[$inc]="$x"
		echo "[$inc] $x"
	    done
	    if [[ "$key_profile" != "off" ]]; then
	        read -p "Selecione o profile:" number
		# Carregando profile do usuário
		if ! source "${the_profile[number]}.profile"; then
		echo -e "${the_profile[number]}.profile não foi carregado!\n"
		sleep 2.5s
		continue
		else
		    break
		fi
	    fi
	    done # Loop principal da escolha
	    popd &>/dev/null
	   break # Parando o loop principal
	;;
	3) echo "AJUDA" ;;
        4) exit 0 ;;
	*) echo "Comando não encontrado..."; sleep 2s ;;
    esac
done
kill "$pid"

# Contar a historia?
if [[ "$history" = '1' ]]; then
    clear
    _SOUND "som/abertura.mp3"
    _WRITE "Há mais de 200 anos...

Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 

Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 

Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla, 
Bla bla bla, bla bla bla, Bla bla bla, bla bla bla,"
    # Alterando a chave history
    sed -i "s@history=.*@history='0'@" "profile/${name}.profile"
    _ENTER #Chamada modulo
    kill "$pid"
fi

echo "A historia não foi contada."
