#!/bin/zsh

for i in {000..255..16}; do
  for j in {$i..$((i+15))}; do
    echo -en "\e[38;5;${j}m $j \e[0m"
  done
  echo
done
