#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
vundledir=~/dotfiles/.vim/bundle/Vundle.vim
files="vimrc vim zshrc oh-my-zsh tmux.conf tmux aliases bashrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
	if [ -f ~/.$file ] && [ -f $dir/.$file ]; then
		echo "Moving any existing dotfiles from ~ to $olddir"
		mv ~/.$file $olddir
	fi
	#if [ -f $dir/.$file ]; then
		echo "Creating symlink to $file in home directory."
		ln -s $dir/.$file ~/.$file
	#fi
done

# check if vundle directory exists so git doesn't fail
cd $dir/.vim/bundle
if [ ! -d "$vundledir" ]; then
	git clone https://github.com/gmarik/Vundle.vim.git
fi
