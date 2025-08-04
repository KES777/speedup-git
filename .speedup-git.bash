
# Copyright (C) 2015-2025 by Eugen Konkov

# Adjust your ./ssh/config to set up your remote editing
# host <host_alias>
#   user <user>
#   hostname <host or ip>
#   PreferredAuthentications publickey
#   port 22
#   Identityfile ~/.ssh/id
#   RemoteForward 52697 127.0.0.1:52698

if [ -z "$SSH_CLIENT" ]; then
	export EDITOR="subl"
else
    export EDITOR_NOLINE=1
	export EDITOR="rsub --port 52697"
	export RMATE_PORT="52697"
fi

PSQL_EDITOR="$EDITOR -w"


_absolute(){ for arg in "$@"; do echo -n " $(pwd)/$arg"; done; }
alias SE='eval `make setenv`'

alias gn="GD_RELATIVE=1 git-number"
alias gh="gn follow"
alias gb="gn -c git blame"
# TODO: pass line parameter
alias ge="gn -c $EDITOR"
alias ga="gn add"
alias gr="gn -c git reset HEAD"
alias gap="GIT_EDITOR='$EDITOR -w' gn add -p"
alias gd="gn diff -b -w --ignore-blank-lines"
alias gdc="gn diff -b -w --ignore-blank-lines --color-words='\"[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+\"'"
alias gds="gd --staged"
# TODO: apply --autostash
# This is useful when you want to save part of current changes as branch and then switch back
alias gc="gn checkout"
alias gcf="git flow feature checkout"
# --full-history -- do not miss empty commits
# 'f(){ echo before "$@" after;  unset -f f; }; f'
alias gl='f(){ gn log -w -b -p --ignore-blank-lines --full-history $@; unset -f f; }; f'
alias glc="gl --color-words='\"[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+\"'"
alias gls="gl --stat"
alias gfc='f(){ git fullchanges ${1:-HEAD}...master; }; f'
alias cm="GIT_EDITOR='$EDITOR -w' git commit"
alias ca="GIT_EDITOR='$EDITOR -w' git commit --amend"
alias grb="GIT_EDITOR='$EDITOR -w' git rebase -v --autostash --rebase-merges -i"
alias grbc="GIT_EDITOR='$EDITOR -w' git rebase --continue"

# git fetch required to not lose changes on remote branch
# We can not do `git fetch origin` because origin may not exists
# https://habr.com/company/mailru/blog/318508/
alias gpf="git push --force-with-lease"

source ~/.git-completion.bash
# source <(kubectl completion bash)
__git_complete gn  _git
__git_complete ga  _git_add
__git_complete gap _git_add
__git_complete gd  _git_diff
__git_complete gds _git_diff
__git_complete gc  _git_checkout
__git_complete gl  _git_log
__git_complete gh  _git_log
__git_complete gls _git_log
__git_complete cm  _git_commit
__git_complete ca  _git_commit
__git_complete grb _git_rebase


# TODO: We need to update autocompletion script, because 'gpf' alias does not work correct:
# kes@work ~/t $ git push --force TABTAB
# amazon   zzz

# kes@work ~/t $ git push --force zzz TABTAB
# amazon/Makefile                                  zzz/example
# amazon/openapi3                                  zzz/schema
# amazon/cp_app                                    zzz/project
# create_schema                                    zzz/dev_x
# FETCH_HEAD                                       zzz/dev_x_v3
# HEAD                                             zzz/gh-pages
# Makefile                                         zzz/openapi3
# ORIG_HEAD                                        xxx

# kes@work ~/t $ git push --force zzz openapi3^C
# kes@work ~/t $ gpf TABTAB
# amazon   zzz

# kes@work ~/t $ gpf amazon TABTAB
# amazon   zzz
__git_complete gpf _git_push


# Make complition works for git alias: _git_<alias_name>
_git_grb(){
	_git_rebase
}
_git_reauthor(){
  _git_diff
}


# change directory to parent bypassing symlinks.
alias cdf='cd $(pwd -P); echo "Leaving: $(basename $PWD)"; cd ..'

# change directory by number
gcd() {
    gn -c test -d "$(git list $1)" && cd $(git list $1)  || test -f "$(git list $1)" && cd $(dirname $(git list $1))
}
