#!/bin/zsh

#xdef="$HOME/.Xdefaults"
#colors=( $( sed -re '/^!/d; /^$/d; /^#/d; s/(\*color)([0-9]):/\10\2:/g;' $xdef | grep 'color[01][0-9]:' | sort | sed  's/^.*: *//g' ) )

colors=($(xrdb -query | sed -n 's/.*color\([0-9]\)/\1/p' | sort -nu | cut -f2))

echo -e "\e[37m 
   BLK      RED      GRN      YEL      BLE      MAG      CYN      WHT   
──────────────────────────────────────────────────────────────────────\e[0m"
for i in {0..7}; echo -en "\e[$((30+$i))m $colors[i+1] \e[0m"
echo
for i in {8..15}; echo -en "\e[1;$((22+$i))m $colors[i+1] \e[0m"
echo -e "\n"
