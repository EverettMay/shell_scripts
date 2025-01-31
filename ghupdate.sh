#!/usr/bin/zsh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd /home/Desktop/everything
git add .
git cm "auto update"
git push

cd /home/Desktop/homework
git add .
git cm "auto update"
git push

cd /home/Desktop/dotfiles
git add .
git cm "auto update"
git push

cd /home/Desktop/TA_files
git add .
git cm "auto update"
git push

cd /home/Desktop/cheatsheets
git add .
git cm "auto update"
git push