## GIT commands

`gn` - `git status`

`git tree` - `git log`. Useful when we want to see where we are

`git fullchanges SHA1...SHA2` - `git log`. Useful when we want to see the differences between branches.

`git cdiff SHA1...SHA2` - `git rangediff`. Shows the actual changes between branches

`gd <number>` - `git diff`. Shows difference at file with <number>

`gdc <number>` Show changes symbol by symbol, not line by line

`gdc --staged <number>` - the same as `gdc` but for the staged files.

`git prb` - `pull -v --rebase=merges`

`git erb <branch>` - `git rebase ...` Easy rebasing current branch on the top another branch.

`git fom` - `git fetch origin master:master` Useful when we want to update another branch without switching to it.

`gap <number>` - `git add --patch`. Mark changes one by one for commit.

`gr <number>` - `git reset`. Unstage some files. Useful with `-p` . Eg. `gr -p 3` - reset changes hunk by hunk.

`gc` - `git checkout`. Cool alias. Save a lot of typing. `gc -b <brach>` Create a new branch and switch to it. `gc -p <number>` Similar to `gr -p` just reverts your local changes.

`git cp` - `git cherry-pick`. It looks like regular cp/copy command. Nice to have.

`git br` - `git branch`. Also not bad alias. Saves a lot of typing. Usually `git br -D <local branch>`

`git track` - `git branch --set-upstream-to ....` Associate local branch with the remote one.

`git sl` - `git stash list`

`git ss` - `git stash show`. By default shows the latest stash. But we can use `git ss <number>`

`git sa <number>` - `git stash apply stash@{$1}`

`gh <number> <line1> <line2>` - `git follow`. Killer feature. Like `git blame` but we can see all changes/commits for the given range of code.

`gcd <number>` - cd into a directory where file is located.

## Info

Many features still undocumented.

The functionality hardly relays on `git-number`. Please install this https://github.com/holygeek/git-number

Add into your `.bashrc` or `.bash_aliases`
```
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

[ -f ~/.speedup-git.bash ]  &&  source ~/.speedup-git.bash
```

Additionally you can install `rsub` from https://github.com/aurora/rmate to be able to edit remote files in an editor on your local machine.
