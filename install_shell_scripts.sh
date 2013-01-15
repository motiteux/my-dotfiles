#!/bin/bash
for i in $(ls -a $(pwd)/etc);
do
	if [ -e ~/$i ]; then 
		rm -rf ~/$i
	fi
    ln -sf $(pwd)/etc/$i ~/$i;
    echo "Installed $i into $HOME";
done;
