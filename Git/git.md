## General
```sh
git --help
git Command -h
git status
```

## Project
```sh
cd Folder
git init

# New File
git add File1.txt
git commit -m "Describe"
git add --all

# Chnage File
git add .
git commit

# Remove File
## A
git reset HEAD NewFile.txt
## B
git rm --cached NewFile.txt

# Others
git log
git tag TagName Commit(SHA-1) -a -m "This is first tag"
```

## Branch
```sh
git branch

# New branch
git branch Other

# Change branch
git checkout Other

# History
## in git bash
git config --global alias.tree "log --graph --decorate --pretty=oneline --abbrev-commit"

## alias.`tree`
git tree

# Merge branch
git checkout master
git merge Other
```