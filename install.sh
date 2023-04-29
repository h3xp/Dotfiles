#!/bin/bash


# colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color


config_files=(
    "$HOME/.config/alacritty/alacritty.yml"
    "$HOME/.config/i3/config"
    "$HOME/.config/i3/volume.sh"
    "$HOME/.config/polybar/config.ini"
    "$HOME/.config/polybar/docker.sh"
    "$HOME/.config/polybar/launch.sh"
    "$HOME/.config/polybar/mic_status.sh"
    "$HOME/.config/polybar/vpn_status.sh"
    "$HOME/.config/rofi/config.rasi"
    "$HOME/.config/rofi/custom_scripts.sh"
    "$HOME/.screenlayout/hdmi-duplicate.sh"
    "$HOME/.screenlayout/hdmi-extended.sh"
    "$HOME/.screenlayout/laptop.sh"
    "$HOME/.screenlayout/office.sh"
    "$HOME/.screenlayout/office_laptop_in_front_of_screens.sh"
)

# themes seperated by ;
# alacritty
#    https://draculatheme.com/alacritty
#    https://github.com/dracula/alacritty.git
themes=(
    "https://github.com/dracula/alacritty.git;$HOME/.themes/dracula/alacritty"
)


# backing up existing files
printf "[*] backing up existing files\n"
for f in ${config_files[@]}
do
    if [ -f "$f" ]
    then
        printf "    ${BLUE}CP: $f\n${NC}"
        cp $f $f.pre-hexp
    else
        printf "    ${GRAY}CP: $f\n${NC}"
    fi
done


# removing existing files
printf "[*] removing existing files\n"
for f in ${config_files[@]}
do
    if [ -L "$f" ] || [ -f "$f" ]
    then
        printf "    ${BLUE}RM: $f\n${NC}"
        rm $f
    else
        printf "    ${GRAY}RM: $f\n${NC}"
    fi
done


# downloading draculatheme
printf "[*] download draculathemes\n"
for t in ${themes[@]}
do
    arrt=(${t//;/ })
    dt=${arrt[1]}
    st=${arrt[0]}
    if [ -d "$dt" ]
    then
        printf "    ${BLUE}git pull $dt\n${GRAY}"
        git -C $dt pull
        printf "${NC}"
    else
        printf "    ${BLUE}git clone $st $dt\n${GRAY}"
        git clone "$st" "$dt"
        printf "${NC}"
    fi
done


# creating symlinks
printf "[*] creating symlinks\n"

# alacritty dracula theme
printf "    ${BLUE}LINK: $HOME/.themes/dracula/alacritty/dracula.yml $HOME/.config/alacritty/dracula.yml${NC}\n"
if [ -f "$HOME/.config/alacritty/dracula.yml" ]
then
    rm $HOME/.config/alacritty/dracula.yml
    ln -s "$HOME/.themes/dracula/alacritty/dracula.yml" "$HOME/.config/alacritty/dracula.yml"
fi

# files from repo
for f in ${config_files[@]}
do
    dc="${f/.config/dot-config}"
    ds="${dc/.screenlayout/dot-screenlayout}"
    h="${ds/$HOME/$PWD}"
    printf "    ${BLUE}LINK: $h $f${NC}\n"
    ln -s $h $f
done



# GG
printf "[+] done, restarting i3 now\n${NC}"
i3 restart
printf "${GREEN}[+] everything done\n${NC}"
