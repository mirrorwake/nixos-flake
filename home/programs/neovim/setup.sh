#!/bin/bash
origin=$(pwd)/config
target=~/.config/nvim
read -p "This action will delete the contents of $target and replace them with symlinks to this directory. Do you wish to continue?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  sudo rm -rf ~/.config/nvim
  ln -s $origin $target
  echo "$origin copied to $target!"
fi
