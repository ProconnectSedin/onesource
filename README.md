### OneSource
Respository for onesource schemas and Procedures

### Steps to update repo
* git add
* git commit
* git push

⚠️ git pull before commit, otherwise you may face a merge conflict

### If you want to keep files in this folder but don't want to upload it to Github
Just add the file name or pattern to .gitignore

### Creating and switching branches
`git branch development` # create new branch

`git checkout development` #switch to new branch

You can also switch branch by clicking on the git icon in the bottom left of VS Code

Changes in the development brach can be merged from github.com by creating a pull request from Pull requests tab

IMPORTANT 🚨: Please be descriptive in your commit messages

### How to switch to development
1. Make sure there are no un-pushed commits. If any, uncommit the commits
2. Change the repo link using `git remote set-url origin https://github.com/ProconnectSedin/onesource`
3. Add, commit, push if you have any changes
4. Change branch using `git checkout development`

### When you have too many files to add
Run `git add .` to add all changed files if you have too many files to add
![Too many files](https://i.imgur.com/k3eYtNA.png)
