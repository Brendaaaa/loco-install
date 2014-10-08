#!/bin/bash

is_seted () {
    if echo $PACKAGES | grep -q "\b$1\b"; then
       echo 'on'
    else
        echo 'off'
    fi
}

install_menu () {

     packages=$(dialog --checklist "Install Apps" 35 40 35 \
        'build-essential' 'Build essential' $(is_seted 'build-essential') \
        'skype' "Cliente de conversas" $(is_seted 'skype') \
        'latex-full' 'Instalação completa do latex' $(is_seted 'latex-full')\
#         
        'gcc' '' $(is_seted 'gcc')\
        'texlive-full' 'latex' $(is_seted 'texlive-full')\
        'vim' '' $(is_seted 'vim') \
	'gvim' '' $(is_seted 'gvim') \
	'emacs' '' $(is_seted 'emacs') \
	'g++' '' $(is_seted 'g++') \
	'make' '' $(is_seted 'make') \
	'cmake' '' $(is_seted 'cmake') \
	'automake' '' $(is_seted 'automake') \
	'python' '' $(is_seted 'python') \
	'ipython' '' $(is_seted 'ipython') \
	'google-chrome-stable' '' $(is_seted 'google-chrome-stable') \
	'pidgin' '' $(is_seted 'pidgin') \
	'mplayer' '' $(is_seted 'mplayer') \
	'guake' '' $(is_seted 'guake') \
	'yakuake' '' $(is_seted 'yakuake') \
	'subversion' 'svn' $(is_seted 'subversion') \
	'git' '' $(is_seted 'git') \
	'tmux' '' $(is_seted 'tmux') \
	'gdb' '' $(is_seted 'gdb') \
	'valgrind' '' $(is_seted 'valgrind') \
	'dropbox' '' $(is_seted 'dropbox') \
	'clang' '' $(is_seted 'clang') \
	'zsh' '' $(is_seted 'zsh') \
	'ctags' '' $(is_seted 'ctags') \
	'transmission' '' $(is_seted 'transmission') \
	'openjdk-7-jdk openjdk-7-jre' 'java' $(is_seted 'openjdk-7-jdk openjdk-7-jre') \
	'okular' '' $(is_seted 'okular') \
	'playonlinux' '' $(is_seted 'playonlinux') \
	'virtualbox' '' $(is_seted 'virtualbox') \
	'htop' '' $(is_seted 'htop') \
	'tree' '' $(is_seted 'tree') \
	'rsync' '' $(is_seted 'rsync') \
	'sshfs' '' $(is_seted 'sshfs') \
	'meld' '' $(is_seted 'meld') \
	'openssh-server' '' $(is_seted 'openssh-server') \
        --stdout)

     # testa se ok foi precionado
     if [ $? = 0 ]; then
         PACKAGES=$packages
     fi

     main_menu
}


# var='sudo'
# gpkg=''
# 
# install_menu () {
# 
#     entry=$(dialog --menu "Selecionar gerenciador de pacotes" 10 30 3\
#         'apt' 'Ubuntu, Debian...'\
#         'yum' 'Fedora, CentOS'\
#         'Voltar' ''\
#         --stdout) 
# 
#     case $entry in
#         'apt')
# 	    gpkg=' apt'
#             programs_menu
#             ;;
#         'yum')
# 	    gpkg=' yum'
#             programs_menu
#             ;;
#         'Voltar')
# 	    main_menu
# 	    ;;
# 
#     esac 
# 
# }


internet_config () {

    entry_ip=$(dialog --inputbox "Enter network IP:" 8 30 $IP --stdout) 

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
