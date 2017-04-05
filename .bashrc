# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions


export NCURSES_NO_UTF8_ACS=1
export PATH=~/bin/emacs/bin:$PATH
export JAVA_HOME=~/bin/jdk1.8.0_77
export PATH=~/bin:~/bin/jdk1.8.0_77/bin:$PATH:$HOME/bin:~/bin:$PATH


# User specific aliases and functions
source /usr/share/git-core/contrib/completion/git-prompt.sh
export PS1='\u@\h \[$(tput setaf 6)\]\w\[$(tput sgr0)\]\[$(tput setaf 3)\]$(__git_ps1)\[$(tput sgr0)\] \$ '

alias ec='emacsclient -t -a ""'
alias ecc='ec -c'
export EDITOR="ec"

ediff_func () {
        emacs --eval "(ediff-files \"$1\" \"$2\")"
}
alias ediff=ediff_func

http_proxy=http://xxxx:8080
https_proxy=http://xxxx:8080

urlencode() {
    printf "%s" "$*" | od -An -tx1 | tr ' ' '%'
}
 
setup_proxy ()
{
    echo "Username: $USER";
    read -s -p "Password: " PASSWD;
    echo;
    # Trim the scheme, username and password off the proxy (if any)
    http_proxy=${http_proxy#http://*@}
    # In case there wasn't a username and password, just trim off the scheme
    http_proxy=${http_proxy#http://}
    # Put it all back together
    http_proxy="http://$(urlencode "$USER"):$(urlencode "$PASSWD")@$http_proxy"
	export http_proxy=$http_proxy
    export https_proxy=$http_proxy;
    unset PASSWD
}

grepcc ()
{
    grep -r -F "$1" --include=\*.{h,cc} $2 | grep -v ".git" | grep -v "test"
}

grepccall ()
{
    grep -r -F "$1" --include=\*.{h,cc} $2 | grep -v ".git"
}


greppy ()
{
    grep -r -F "$1" --include=\*.py $2
}

grepsrc ()
{
    grep -r -F "$1" --include=\*.{h,cc,py} $2 | grep -v ".git" | grep -v "test"
}

translate()
{
    #    echo "$1" | sed  "s/ /0x/g" | xxd -r | iconv -f gb2312 -t utf-8
    python ~/mine/translate.py $1
}

gentag()
{
    rm -f $1/TAGS
    find $1 -type f -and \( -name "*.cc" -print -or -name "*.cpp" -print -or -name "*.c" -print -or -name "*.h" -print \)  | grep -v "test" | xargs etags --append $1/TAGS
}

genalltag()
{
    rm -f $1/TAGS
    find $1 -type f -and \( -name "*.cc" -print -or -name "*.cpp" -print -or -name "*.c" -print -or -name "*.h" -print -or -name "*.py" -print \) | grep -v "test" | xargs etags --append $1/TAGS
}

gengtag()
{
    rm -f $1/GPATH $1/GRTAGS $1/GTAGS
    find $1 -type f -and \( -name "*.cc" -print -or -name "*.cpp" -print -or -name "*.c" -print -or -name "*.h" -print \)  | grep -v "test" | gtags -f - $1
}

genallgtag()
{
    rm -f $1/GPATH $1/GRTAGS $1/GTAGS
    find $1 -type f -and \( -name "*.cc" -print -or -name "*.cpp" -print -or -name "*.c" -print -or -name "*.h" -print -or -name "*.py" -print \) | grep -v "test" | gtags -f - $1
}


gentagwithtest()
{
    rm -f $1/TAGSWithTests
    find $1 -type f -and \( -name "*.cc" -print -or -name "*.h" -print \) | xargs etags --append $1/TAGSWithTests
}

genalltagwithtest()
{
    rm -f $1/TAGSAll
    find $1 -type f -and \( -name "*.cc" -print -or -name "*.h" -print -or -name "*.py" -print \) | xargs etags --append $1/TAGSAll
}

redep()
{
    rm -rf .git/externals/
    rm -rf x_*
    rm -rf .git/git_utils
    ./git_setup.py
}

getlog()
{
    LOG_SYNC_SERVER='jinyux@central-archive'
    LOG_FILE_PATH='/u01/archive_sync/yyyy/'
    #cmd="${LOG_SYNC_SERVER}:${LOG_FILE_PATH}/$1"
    #echo $cmd
    scp ${LOG_SYNC_SERVER}:${LOG_FILE_PATH}/$1 $2
}

findlog()
{
    LOG_SYNC_SERVER='jinyux@central-archive'
    cmd="find /u01/archive_sync/yyyy/$1 -maxdepth 1 -type f -printf %f\\\\n"
    echo $cmd
    ssh ${LOG_SYNC_SERVER} ${cmd}

    #LOG_FILE_PATH=/u01/archive_sync/yyyy/
    #ssh jinyux@central-archive 'find /u01/archive_sync/yyyy/$1 -maxdepth 1 -type f -printf %f\\n'
    #ssh ${LOG_SYNC_SERVER} 'find $LOG_FILE_PATH/$1 -maxdepth 1 -type f -printf %f\\n'
}

get_license()
{
    pushd $PWD
    cd /home/jinyux/soft/onetick20140114/one_market_data/one_tick/bin && ./local_license_getter.exe -features "COLL, LOAD, QUERY"
    popd
}

grep_ansible()
{
    grep -r $1 --exclude-dir=local --exclude-dir=virtualenv --exclude-dir=temp_deployment --exclude-dir=.git $2
}



