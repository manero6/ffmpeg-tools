#!/bin/bash

if [ $# = 1 ]
then
  LIST=`ls | grep -i "$1" | sed -e "s/^/file '/" -e "s/$/'/"`
  if [[ -f list ]]
  then 
    read -p "Do you want to overwrite the already existing 'list' file? (y/N) " yn
    case $yn in 
      [yY]* ) echo -e "\nOverwriting already existing 'list' file with the following content:\n"
              echo "$LIST"
              echo
              echo "$LIST" > list
              ;;
      * ) echo -e "\nExiting...\n"
          exit
          ;;
    esac
  else
    echo -e "\nCreating \"list\" file with the following content:\n"
    echo "$LIST"
    echo
    echo "$LIST" > list
  fi
else
  echo ERROR: One argument must be given
  echo
fi
