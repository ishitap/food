#!/bin/sh
CURDIR=$(pwd)
while [ 1 ]; do
    cd ../
    if git pull | head -n 1 | grep -c "Already up-to-date." > /dev/null; then
        echo -n "Already up to date: "
        date
    else
        cd $CURDIR
        echo "DEPLOYING"
        ./deploy.sh
        echo "DONE DEPLOYING"
    fi
    sleep 10
done
