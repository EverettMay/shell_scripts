#!/usr/bin/zsh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd /home/everett/Desktop/everything
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/homeworks
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/books
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/dotfiles
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/TA_files
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/cheatsheets
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/wallpapers
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/komowataharuka
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/CLRS_for_dummies
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/projects/website
git pull
git add .
git cm "auto update"
git push


cd /home/everett/Desktop/projects/shell_scripts
git pull
git add .
git cm "auto update"
git push


cd /home/everett/Desktop/projects/resume
git pull
git add .
git cm "auto update"
git push


cd /home/everett/Desktop/projects/shell
git pull
git add .
git cm "auto update"
git push


cd /home/everett/Desktop/projects/blog
git pull
git add .
git cm "auto update"
git push


cd /home/everett/Desktop/projects/every_data_structures-algorithms_implementations
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/projects/uwu
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/projects/SMS
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/robocanes
git pull
git add .
git cm "auto update"
git push

cd /home/everett/Desktop/packages
git pull
git add .
git cm "auto update"
git push