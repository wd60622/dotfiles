# Open Github of the local
function gh() {
    local url_root="$(git config --get remote.origin.url)"
    if [ -z  "$url_root" ]
    then
        echo "There is no remote!"
    else
        url_root=${url_root%.git}
        if [ -z "$1" ]
        then
            local current_branch="$(git branch --show-current)"
        else
            local current_branch="$1"
        fi
        local url_name="$url_root/tree/$current_branch"
        chrome $url_name
    fi
}

function finder() {
    local dir="$PWD"
    open $dir
}

# Add a remote and push up to main
function add_remote() {
    local git_url=$1

    git remote add origin $git_url
    git push -uf origin main
}

# Add location to PYTHONPATH
function addpp() {
    export PYTHONPATH=${PYTHONPATH}:${HOME}/$1
}

# Use rich to print out the current readme
function readme() {
    if [ "$1" != "" ]
    then
        python3 -m rich.markdown $1 --hyperlinks
    else
        python3 -m rich.markdown README.md --hyperlinks
    fi
}

# Adding and removing jupyter kernels
function new_kernel() {
    ipython kernel install --name "$1" --user
}

function remove_kernel() {
    jupyter kernelspec remove "$1"
}

# Link file to ZSH_CUSTOM
function zsh-link() {
    ln -s $(pwd)/$1 $ZSH_CUSTOM
}

# From https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/#how-to-test-your-shell-load-time
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
