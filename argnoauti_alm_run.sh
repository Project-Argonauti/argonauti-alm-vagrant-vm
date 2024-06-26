#!/usr/bin/env bash

pull_method=true

ALM_VM_NAME="argonauti.alm"
ALM_WORK_PATH=$PWD
ALM_GIT_REPOSITORIES=( 
    "git@github.com:Project-Argonauti/ansible-jenkins.git"
)

ALM_ANSIBLE_ROLE_PATH="/e/project-argonauti/argonauti-alm-vagrant-vm/roles"

log() {
    echo "[$(date --utc) - $1]: $2"
}

puller () {
    local path=$1

    log "INFO" "Pulling new commits from $path ..."
    cd $path
    git remote -v
    git stash
    git fetch
    git pull origin main
    cd -
}

cloner () {
    local url=$1
    local output_path=$(basename $url | cut -d '.' -f 1)
    
    if [ ! -d "${output_path}" ]
    then
        log "INFO" "Now cloning $url ..."
        git clone $url  || {
            log "ERROR" "Failed to download $url . Aborting..."
            exit 1
        }
    else 
        if $pull_method
        then
            puller $output_path
        fi
    fi
}

is_vm_running() {
    log "INFO" "Check $ALM_VM_NAME if is running ..."
    vagrant status "$ALM_VM_NAME" | grep -q 'running'
    return $?
}

handle_start() {
    if is_vm_running; then
        log "WARN" "VM $ALM_VM_NAME is already running. Running 'vagrant provision'."
        vagrant provision "$ALM_VM_NAME"
    else
        log "INFO" "VM $ALM_VM_NAME is not running. Running 'vagrant up'."
        vagrant up "$ALM_VM_NAME"
    fi
}

handle_stop() {
    log "INFO" "Stopping the VM $ALM_VM_NAME"
    vagrant halt -f "$ALM_VM_NAME"
}

handle_destroy() {
    log "WARN" "Destroying the VM $ALM_VM_NAME"
    vagrant destroy -f "$ALM_VM_NAME"
}

if [ -z $VAGRANT_DEFAULT_PROVIDER ]
then
    export VAGRANT_DEFAULT_PROVIDER="virtualbox"
fi

if [ ! -d "${ALM_ANSIBLE_ROLE_PATH}" ]
then
    log "INFO" "Creating ansible role path in $ALM_ANSIBLE_ROLE_PATH ..."
    mkdir -p $ALM_ANSIBLE_ROLE_PATH
fi

cd $ALM_ANSIBLE_ROLE_PATH
for repo in ${ALM_GIT_REPOSITORIES[@]}; do
    cloner $repo
done
cd $ALM_WORK_PATH

case "$1" in
    start)
        handle_start
        ;;
    stop)
        handle_stop
        ;;
    destroy)
        handle_destroy
        ;;
    *)
        log "WARN" "No valid argument provided. Defaulting to 'start'."
        handle_start
        ;;
esac