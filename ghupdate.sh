#!/usr/bin/zsh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd /home/everett/Desktop/everything
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/homeworks
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/dotfiles
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/TA_files
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/cheatsheets
git add .
git cm "auto update"
git push