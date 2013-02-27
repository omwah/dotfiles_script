dotfiles_script
===============

make_links.sh - A simple dot files script meant to be deposited in a Git repo. 
The script aims to be idempotent and can be run many times without breaking
links set up in earlier runs. Run the script each time you add new files to
your Git dotfiles repo. Add files to the directory where the script lives
without the preceeding "." in the filename.

This script does the following:
1. Finds all files in and under the directory where it lives that
   are not the script itself, the README or in the .git directory.
2. For each file found it checks if there is an existing regular
   file in the home directory. If so it moves it to the ~/old_dotfiles
   directory.
3. Creates a symbolic link pointing to the file in the repo from
   the a dot file of the same name.

Subsequent runs will ignore any existing symbolic links back into the repo.

Example Usage
-------------

    git clone git@github.com:omwah/dotfiles_script.git ~/.dotfiles
    cd ~/.dotfiles
    ./make_links.sh 
