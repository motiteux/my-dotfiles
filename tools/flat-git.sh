#!/bin/bash 

MERGE_BRANCH=mergetrunk 
REPO=$1
BRANCH=$2 

if [[ -z "${1}" || -z "${2}" ]]; then 
    echo "===> You must provide a \"remote\" and a \"refspec\" for Git to use!" 
    echo "===> Exiting :(" 
    exit 1; 
fi 

LATEST_COMMIT=`git log --max-count=1 --no-merges --pretty=format:"%H"` 

function co_trunk  { 
    echo "==> Making sure we're on 'trunk'" 
    git checkout trunk 
} 

function setup_mergetrunk { 
    co_trunk 
    echo "==> Killing the old mergetrunk branch" 
    git branch -D $MERGE_BRANCH 

    echo "==> Creating a new mergetrunk branch" 
    git checkout -b $MERGE_BRANCH 
    co_trunk  
} 

function cleanup { 
    rm -f .git/SVNPULL_MSG 
}

function prepare_message { 
    co_trunk

    echo "===> Pulling from ${REPO}:${BRANCH}" 
    git pull ${REPO} ${BRANCH} 
    git checkout ${MERGE_BRANCH} 

    echo "==> Merging across change from trunk to ${MERGE_BRANCH}" 
    git pull --no-commit --squash . trunk 

    cp .git/SQUASH_MSG .git/SVNPULL_MSG 

    co_trunk
} 

function merge_to_svn { 
    git reset --hard ${LATEST_COMMIT} 
    co_trunk 
    setup_mergetrunk 

    echo "===> Pulling from ${REPO}:${BRANCH}" 
    git pull ${REPO} ${BRANCH} 
    git checkout ${MERGE_BRANCH} 

    echo "==> Merging across change from trunk to ${MERGE_BRANCH}" 
    git pull --no-commit --squash . trunk 

    echo "==> Committing..." 
    git commit -a -F .git/SVNPULL_MSG && git svn dcommit --no-rebase 

    cleanup 
} 

setup_mergetrunk

prepare_message 

merge_to_svn 

co_trunk 

echo "===> All done!"
