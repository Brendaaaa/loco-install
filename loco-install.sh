#!/bin/bash

is_seted () {

    if echo $PACKAGE | grep -q $1; then
        echo 'on'
    else
        echo 'off'
    fi
}

install_menu () {

     packages=$(dialog --checklist "Install Apps" 10 40 3 \
        'build-essential' 'Build essential' on \
        'skype' "Cliente de conversas" off \
        'latex-full' 'Instalação completa do latex' off\
        --stdout)

     main_menu
}

internet_config () {

    entry_ip=$(dialog --inputbox "Enter network IP:" 8 40 $IP --stdout) 

    if [ $? = 0 ]; then
        IP=$entry_ip
    fi

    config_menu
}

config_menu () {

    entry=$(dialog --menu "Configurations" 10 30 3\
        'Internet' 'Configuration'\
        --stdout) 

    case $entry in 
        'Internet')
            internet_config
            ;;
    esac
}

main_menu () {

    entry=$(dialog --menu "LOCO" 10 30 3\
        'Install' 'Install new apps'\
        'Configs' 'Configuration'\
        --stdout) 

    case $entry in
        'Install')
            install_menu
            ;;
        'Configs')
            config_menu
            ;;
    esac
}

main_menu

