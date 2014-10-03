#!/bin/bash

is_seted () {
    if echo $PACKAGES | grep -q "\b$1\b"; then
       echo 'on'
    else
        echo 'off'
    fi
}

install_menu () {

     packages=$(dialog --checklist "Install Apps" 10 40 3 \
        'build-essential' 'Build essential' $(is_seted 'build-essential') \
        'skype' "Cliente de conversas" $(is_seted 'skype') \
        'latex-full' 'Instalação completa do latex' $(is_seted 'latex-full')\
        --stdout)

     # testa se ok foi precionado
     if [ $? = 0 ]; then
         PACKAGES=$packages
     fi

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

    entry=$(dialog --title 'ksjadfka' --menu 'Configurations\nfsdaf\n' 10 30 3\
        'Internet' 'Configuration'\
        --stdout) 

    case $entry in 
        'Internet')
            internet_config
            ;;
    esac

    main_menu
}

main_menu () {

  entry=$(dialog --title 'LOCO Setup Install (v0.1)' --menu \
"Welcome to LOCO Linux Setup.\n
Select an option below using the UP/DOWN keys and SPACE or ENTER.\n
Alternate keys may also be used: '+', '-', and TAB." \
 18 72 9 \
 'INSTALL' 'Install new applications'\
 'CONFIGS' 'Reconfigure your Linux system' --stdout) 

 case $entry in
    'INSTALL')
        install_menu
        ;;
    'CONFIGS')
        config_menu
        ;;
  esac
}

main_menu

