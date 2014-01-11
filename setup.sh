#! /bin/sh

current=$(cd $(dirname $0) && pwd)
dotfiles=`ls -A`

cd ~
for dotfile in $dotfiles
do
  if [ "setup.sh" != "$dotfile" -a ".git" != "$dotfile" ]; then
    rm -f "./$dotfile"
    ln -s "$current/$dotfile" "./$dotfile"
  fi
done

