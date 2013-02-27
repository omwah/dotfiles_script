#!/bin/sh

script_name=`basename $0`
script_dir=`dirname $0`
script_dir=`readlink -f $script_dir`
bak_dir="$HOME/old_dotfiles"

# Find files in script dir that are not dot files themselves and not in the git directory
# Excluding the name of the script itself
for src_file in `find $script_dir -type f -and '(' '!' -path "*/.git/*" ')' -and '(' '!' -name ".*" ')' -and '(' '!' -name "*.md" ')' | grep -v $script_name`; do
    # dotfile is name of file in script_dir minus its path
    dotfile=`echo $src_file | sed "s|${script_dir}\/||g"`
    dest_file="$HOME/.${dotfile}"

    # If the existing file is a link to a different file then delete it 
    if [ -L "$dest_file" ]; then
        if [ `readlink -f $dest_file` != "$src_file" ]; then
            echo "Removing existing symbolic link for $dotfile:" `readlink -f $dest_file`
            rm $dest_file
        fi

    # Back up any existing destination files before linking
    elif [ -f "$dest_file" ]; then
        bak_file="$bak_dir/$dotfile"
        if [ ! -d `dirname $bak_file` ]; then
            mkdir -p `dirname $bak_file`
        fi
        echo "Moving existing dotfile: $dest_file -> $bak_file"
        mv $dest_file $bak_file
    fi

    # Create link for destination link if needed
    if [ ! -d `dirname $dest_file` ]; then
        echo "Creating directory for $dotfile:" `dirname $dest_file`
        mkdir -p `dirname $dest_file`
    fi

    # If the link is not already present then create it
    if [ ! -e "$dest_file" ]; then
        echo "Setting up link for $dotfile"
        ln -s $src_file $dest_file
    fi
done
