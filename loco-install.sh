#!/bin/bash

PACKAGES="GCC LATEX-FULL VIM"

#Run as root...
# if [[ $UID -ne 0 ]]; then echo "Only root can configurate..." && exit 1; fi

is_seted () {
    if echo $PACKAGES | grep -q "\b$1\b"; then
       echo 'on'
    else
        echo 'off'
    fi
}

# 'openjdk-7-jdk openjdk-7-jre' 'java' $(is_seted 'openjdk-7-jdk openjdk-7-jre') \
install_menu () {

     packages=$(dialog --title 'Install Apps' --checklist '' 18 72 9 \
        'GCC' 'GNU C compiler' $(is_seted 'GCC')\
        'G++' 'GNU C++ compiler' $(is_seted 'g++') \
        'LATEX' 'TeX Live: basic packages' $(is_seted 'texlive-full')\
        'LATEX-FULL' 'TeX Live: all packages' $(is_seted 'LATEX-FULL')\
        'VIM' 'Vi IMproved - enhanced vi editor' $(is_seted 'VIM') \
        'GVIM' 'Vi IMproved - enhanced vi editor - with GUI' $(is_seted 'gvim') \
        'EMACS' 'GNU Emacs editor' $(is_seted 'emacs') \
        'MAKE' 'Utility for directing compilation' $(is_seted 'make') \
        'CMAKE' 'Cross-platform, open-source make system' $(is_seted 'cmake') \
        'AUTOMAKE' 'Tool for generating Makefiles' $(is_seted 'automake') \
        'PYTHON' 'High-level object-oriented language' $(is_seted 'python') \
        'IPYTHON' '' $(is_seted 'ipython') \
        'CHROME' '' $(is_seted 'google-chrome-stable') \
        'PIDGIN' '' $(is_seted 'pidgin') \
        'MPLAYER' '' $(is_seted 'mplayer') \
        'GUAKE' '' $(is_seted 'guake') \
        'YAKUAKE' '' $(is_seted 'yakuake') \
        'SUBVERSION' 'svn' $(is_seted 'subversion') \
        'GIT' '' $(is_seted 'git') \
        'TMUX' '' $(is_seted 'tmux') \
        'GDB' '' $(is_seted 'gdb') \
        'VALGRIND' '' $(is_seted 'valgrind') \
        'DROPBOX' '' $(is_seted 'dropbox') \
        'CLANG' '' $(is_seted 'clang') \
        'ZSH' '' $(is_seted 'zsh') \
        'CTAGS' '' $(is_seted 'ctags') \
        'TRANSMISSION' '' $(is_seted 'transmission') \
        'OKULAR' '' $(is_seted 'okular') \
        'PLAYONLINUX' '' $(is_seted 'playonlinux') \
        'VIRTUALBOX' '' $(is_seted 'virtualbox') \
        'HTOP' '' $(is_seted 'htop') \
        'TREE' '' $(is_seted 'tree') \
        'RSYNC' '' $(is_seted 'rsync') \
        'SSHFS' '' $(is_seted 'sshfs') \
        'MELD' '' $(is_seted 'meld') \
        'SSH-SERVER' '' $(is_seted 'openssh-server') \
            --stdout)

     # testa se ok foi pressionado
     if [ $? = 0 ]; then
         PACKAGES=$packages
     fi
     
    for opt in ${packages[@]}; do
        case $opt in
            'GCC')
                echo "install gcc"
                ;;
            'TREE')
                echo "installing tree"
                ;;
        esac
    done

    # main_menu
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
