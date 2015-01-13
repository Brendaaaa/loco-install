#!/bin/bash

MOREPACKAGES=""
PACKAGES="GCC LATEX-FULL VIM"

#Run as root...
if [[ $UID -ne 0 ]]; then echo "Only root can configurate..." && exit 1; fi

is_seted () {

    case $1 in 
        'spotify-client')
           $MOREPACKAGES="$MOREPACKAGES sudo apt-add-repository -y \"deb http://repository.spotify.com stable non-free\" && \nsudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59";;
        'skype')
           $MOREPACKAGES="$MOREPACKAGES sudo add-apt-repository \"deb http://archive.canonical.com/ $(lsb_release -sc) partner\"";;
        'sublime')
           $MOREPACKAGES="$MOREPACKAGES sudo add-apt-repository ppa:webupd8team/sublime-text-3";;
    esac

    if echo $PACKAGES | grep -q "\b$1\b"; then
        echo 'on'
    else
        echo 'off'
    fi
}

install_menu () {

     packages=$(dialog --title 'Install Apps' --checklist '' 18 90 20 \
        'GCC' 'GNU C compiler' $(is_seted 'GCC')\
        'G++' 'GNU C++ compiler' $(is_seted 'G++') \
        'TEXLIVE-FULL' 'TeX Live: basic packages' $(is_seted 'TEXLIVE-FULL')\
        'LATEX-FULL' 'TeX Live: all packages' $(is_seted 'LATEX-FULL')\
        'VIM' 'Vi IMproved - enhanced vi editor' $(is_seted 'VIM') \
        'GVIM' 'Vi IMproved - enhanced vi editor - with GUI' $(is_seted 'GVIM') \
        'EMACS' 'GNU Emacs editor' $(is_seted 'EMACS') \
        'MAKE' 'Utility for directing compilation' $(is_seted 'MAKE') \
        'CMAKE' 'Cross-platform, open-source make system' $(is_seted 'CMAKE') \
        'AUTOMAKE' 'Tool for generating Makefiles' $(is_seted 'AUTOMAKE') \
        'PYTHON' 'High-level object-oriented language' $(is_seted 'PYTHON') \
        'IPYTHON' 'Enhanced interactive Python shell' $(is_seted 'IPYTHON') \
        'GOOGLE-CHROME-STABLE' 'Browser' $(is_seted 'GOOGLE-CHROME-STABLE') \
        'PIDGIN' 'Graphical instant messaging client' $(is_seted 'PIDGIN') \
        'MPLAYER' 'Media player' $(is_seted 'MPLAYER') \
        'GUAKE' 'Drop-down terminal for GNOME' $(is_seted 'GUAKE') \
        'YAKUAKE' 'Quake-style terminal' $(is_seted 'YAKUAKE') \
        'SUBVERSION' 'Svn- version control system' $(is_seted 'SUBVERSION') \
        'GIT' 'Revision control system' $(is_seted 'GIT') \
        'TMUX' 'Terminal multiplexer' $(is_seted 'TMUX') \
        'GDB' 'GNU Debugger' $(is_seted 'GDB') \
        'VALGRIND' 'System for debugging and profiling programs' $(is_seted 'VALGRIND') \
        'DROPBOX' 'Cloud synchronization engine' $(is_seted 'DROPBOX') \
        'CLANG' 'C, C++ and Objective-C compiler' $(is_seted 'CLANG') \
        'ZSH' 'UNIX command interpreter (shell)' $(is_seted 'CLANG') \
        'CTAGS' 'Generates a tag (or index) file of objects and functions' $(is_seted 'CLANG') \
        'OPENJDK-7-JDK OPENJDK-7-JRE' 'Development environment for Java ME applications' $(is_seted 'OPENJDK-7-JDK OPENJDK-7-JRE') \
        'TRANSMISSION' 'Lightweight BitTorrent client' $(is_seted 'TRANSMISSION') \
        'OKULAR' 'Universal document viewer' $(is_seted 'OKULAR') \
        'PLAYONLINUX' 'Install Windows Games and software on Linux' $(is_seted 'PLAYONLINUX') \
        'VIRTUALBOX' 'Virtualization solution' $(is_seted 'VIRTUALBOX') \
        'HTOP' 'interactive processes viewer' $(is_seted 'HTOP') \
        'TREE' 'Displays an indented directory tree' $(is_seted 'TREE') \
        'RSYNC' 'Remote (and local) file-copying tool' $(is_seted 'RSYNC') \
        'SSHFS' 'Filesystem client based on SSH' $(is_seted 'SSHFS') \
        'MELD' 'Graphical tool to diff and merge files' $(is_seted 'MELD') \
        'OPENSSH-SERVER' 'Secure shell protocol to accept connections from remote computers' $(is_seted 'OPENSSH-SERVER') \
        'AVAHI-DAEMON' 'Framework for Multicast DNS Service Discovery' $(is_seted 'AVAHI-DAEMON') \
        'CSCOPE' 'Interactively examine a C program source' $(is_seted 'CSCOPE') \
        'VLC' 'Multimedia player and streamer' $(is_seted 'VLC') \
        'NTFS-3G' 'Read/write NTFS driver for FUSE' $(is_seted 'NTFS-3G') \
        'ACK-GREP' 'Grep-like program' $(is_seted 'ACK-GREP') \
        'FUSE' 'Filesystem in Userspace' $(is_seted 'FUSE') \
        'ZIP' 'Archiver for .zip files' $(is_seted 'ZIP') \
        'UNZIP' 'De-archiver for .zip files' $(is_seted 'UNZIP') \
        'P7ZIP-FULL' '7z and 7za file archivers with high compression ratio' $(is_seted 'P7ZIP-FULL') \
         'RAR' 'Archiver for .rar files' $(is_seted 'RAR') \
        'UNRAR-FREE' 'Unarchiver for .rar files' $(is_seted 'UNRAR-FREE') \
        'XFIG' 'Facility for Interactive Generation of figures under X11' $(is_seted 'XFIG') \
        'INKSCAPE' 'Vector-based drawing program' $(is_seted 'INKSCAPE') \
        'DOSFSTOOLS' 'Utilities for making and checking MS-DOS FAT filesystems' $(is_seted 'DOSFSTOOLS') \
        'EXFAT-UTILS' 'Utilities to create and check exFAT filesystem' $(is_seted 'EXFAT-UTILS') \
        'EXFAT-FUSE' 'Read and write exFAT driver for FUSE' $(is_seted 'EXFAT-FUSE') \
        'BZR' 'Distributed version control system' $(is_seted 'BZR') \
        'FIREFOX' 'Safe and easy web browser from Mozilla' $(is_seted 'FIREFOX') \
        'CUPS' 'Common UNIX Printing System' $(is_seted 'CUPS') \
        'SUBLIME-TEXT-INSTALLER' 'Text editor for code, markup and prose' $(is_seted 'SUBLIME-TEXT-INSTALLER') \
        'SKYPE' 'A tool to send instant messages and exchange files and images' $(is_seted 'SKYPE') \
        'SPOTIFY-CLIENT' 'Music streaming service' $(is_seted 'SPOTIFY-CLIENT') \
        'LIBREOFFICE-L10N-PT-BR' 'Office productivity suite - PT' $(is_seted 'LIBREOFFICE-L10N-PT-BR') \
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
	 $MOREPACKAGES
	 sudo apt-get update
         sudo apt-get install -y $PACKAGES
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
