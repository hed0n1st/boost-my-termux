#!/data/data/com.termux/files/usr/bin/bash

clear
echo -e "\033[34m[x]pkg update, upgrade and installation\033[0m"

PKG_LIST=(
            termux-am termux-api termux-apt-repo termux-create-package termux-elf-cleaner termux-tools termux-exec tsu
            zsh htop
            ncurses ncurses-utils coreutils findutils apr apr-util dirmngr
            autoconf bison clang
            git openssh
            net-tools dnsutils
            irssi
            wget aria2 rclone rsync syncthing
            p7zip gzip unzip unrar tar
            nano neovim man w3m lynx
            mpv ffmpeg
            golang nodejs-lts python ruby perl
         )

apt update && apt upgrade -y
pkg install -y "${PKG_LIST[@]}"

clear
echo -e "\033[34m[x]Installing profiles and sudo\033[0m"

rm -f ~/.bash_profile
rm -f ~/.zsh_profile

git clone git://github.com/hed0n1st/boost-my-termux.git ~/.boost-my-termux && cd ~/.boost-my-termux
cat bash_profile > ~/.bash_profile
cat bashrc > ~/.bashrc
cat zsh_profile > ~/.zsh_profile
cat zshrc > ~/.zshrc
cat sudo > /data/data/com.termux/files/usr/bin/sudo

chmod 700 /data/data/com.termux/files/usr/bin/sudo

clear
echo -e "\033[34m[x]Installing termux-styling shell script\033[0m"

sleep 2
cp ~/.boost-my-termux/.termux/{colors.list,fonts.list,termux-styling.sh} /data/data/com.termux/files/usr/bin/
mv /data/data/com.termux/files/usr/bin/termux-styling.sh /data/data/com.termux/files/usr/bin/termux-styling
chmod +x /data/data/com.termux/files/usr/bin/termux-styling
sleep 2
rm -rf ~/.boost-my-termux && cd

clear
echo -e "\033[34m[x]Installing oh-my-zsh and oh-my-bash\033[0m"

#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh --depth 1
#cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
git clone git://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash --depth 1
#cp ~/.oh-my-bash/templates/bashrc.osh-template ~/.bashrc

clear
echo -e "\033[34m[x]Installing python packages/ruby gems\033[0m"
echo -e "\033[33m[x]--- python packages and gits\033[0m"
pip install --upgrade pip
pip install pip-review
pip install pyscdl
pip install mps-youtube
pip install spotdl

clear
echo -e "\033[34m[x]Installing python packages/ruby gems\033[0m"
echo -e "\033[33m[x]--- ruby gems\033[0m"
# gem update --system

clear
echo -e "\033[34m[x]Installing personal packages and tools\033[0m"

FDROID_REPO='https://f-droid.org/repo/'
HOME='/data/data/com.termux/files/home/'
APK_LIST=(
            com.termux.api_34.apk
            com.termux.boot_6.apk
            com.termux.styling_25.apk
            com.termux.tasker_3.apk
            com.termux.widget_11.apk
            com.termux.window_11.apk
         )

for f in ${APK_LIST[@]}
do 
    URL=${FDROID_REPO}$f
    clear
    echo -e "\033[34m[x]Installing termux .apk [ fdroid repo ]\033[0m"
    echo -e "\033[33m[x]downloading $f ...\033[0m"
    cd && curl -o $f $URL
    echo -e "\033[33m[x]installing $f ...\033[0m"
    tsu -c pm install -r ${HOME}$f
    rm -f $f
done

clear
echo -e "\033[34m[x]Installing termux personnal style\033[0m"

curl -fsLo ~/.termux/colors.properties --create-dirs https://raw.githubusercontent.com/hed0n1st/boost-my-termux/master/.termux/perso/colors.properties
curl -fsLo ~/.termux/font.ttf --create-dirs https://raw.githubusercontent.com/hed0n1st/boost-my-termux/master/.termux/perso/font.ttf

# -- final steps

termux-setup-storage
echo -e
read -p "Press enter to continue ..."
clear

termux-clipboard-set "source ~/.bash_profile && clear"
echo -e "\033[35m[x]That's all folks. All Done! source added to clipboard\033[0m"
termux-vibrate -d 250
exit
