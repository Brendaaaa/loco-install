#!/bin/bash

#Run as root...
if [[ $UID -ne 0 ]]; then echo "Only root can configurate..." && exit 1; fi

is_seted () {
    if echo $PACKAGES | grep -q "\b$1\b"; then
       echo 'on'
    else
        echo 'off'
    fi
}

# 'openjdk-7-jdk openjdk-7-jre' 'java' $(is_seted 'openjdk-7-jdk openjdk-7-jre') \
install_menu () {

     packages=$(dialog --title 'Install Apps' --checklist '' 35 40 35 \
        'gcc' '' $(is_seted 'gcc')\
        'texlive-full' 'latex' $(is_seted 'texlive-full')\
        'vim' '' $(is_seted 'vim') \
	'vim-gtk' '' $(is_seted 'gvim') \
	'emacs' '' $(is_seted 'emacs') \
	'g++' '' $(is_seted 'g++') \
	'make' '' $(is_seted 'make') \
	'cmake' '' $(is_seted 'cmake') \
	'automake' '' $(is_seted 'automake') \
	'python' '' $(is_seted 'python') \
	'ipython' '' $(is_seted 'ipython') \
	'google-chrome-stable' '' $(is_seted 'google-chrome-stable') \
	'pidgin' '' $(is_seted 'pidgin') \
	'mplayer2' '' $(is_seted 'mplayer') \
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
	'exuberant-ctags' '' $(is_seted 'ctags') \
	'transmission' '' $(is_seted 'transmission') \
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

     # testa se ok foi pressionado
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
        
        #verificar se eh validoooooooooo falta arrumar quando tem espaco antes do numero....
        if [[ $IP =~ [0-9]{1,3}$ ]] && [[ ${IP} -le 255 ]]; then
	    stat=$?
# 	    echo "ip:$IP e stat:$stat" >> verificacao.txt
	    return $stat
	else
	  dialog --title 'Ops' --msgbox 'Only numbers: [0,255]' 8 30
	fi
#     return $stat
    fi

    main_menu
}

config_menu () {

    entry=$(dialog --title 'Configuration' --menu '' 10 30 3\
        'Internet' 'Configuration'\
        --stdout) 

    case $entry in 
        'Internet')
            internet_config
            ;;
    esac

    main_menu
}

finish_menu (){

    dialog --title "Finish" --yesno "Are you sure you want to finish configuring this computer?" 6 40
    
    response=$?

    case $response in
      0) cd /etc/network/
	 echo -e "\nauto eth0\niface eth0 inet static\naddress 10.43.21.$IP\nnetmask 255.255.255.0\ngateway 10.43.21.1\n" >> interfaces
	 cd ../resolvconf/resolv.conf.d/
	 echo -e "domain loco.ic.unicamp.br\nsearch loco.ic.unicamp.br\nnameserver 143.106.7.31\nnameserver 143.106.2.5\nnameserver 8.8.8.8\nnameserver 8.8.4.4\n" >> tail
	 sudo apt-get update
         sudo apt-get install $PACKAGES
	 exit 0;;
      1) main_menu;;
      255) main_menu;;
    esac
    
}

main_menu () {

  entry=$(dialog --title 'LOCO Setup Install (v0.1)' --menu \
  "Welcome to LOCO Linux Setup.\nSelect an option below using the UP/DOWN keys and SPACE or ENTER.\n
   Alternate keys may also be used: '+', '-', and TAB." 18 72 9 \
 'INSTALL' 'Install new applications'\
 'CONFIGS' 'Reconfigure your Linux system' \
 'FINISH' 'Finish setup' --stdout) 

 case $entry in
    'INSTALL')
        install_menu
        ;;
    'CONFIGS')
        config_menu
        ;;
    'FINISH')
	finish_menu
	;;
  esac
}

main_menu
