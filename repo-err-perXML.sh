#!/bin/bash

FILE=".repo/manifest.xml"

if [ -e "./log.txt" ] ; then
        cat ./log.txt | grep Error >> newlog.txt
        while read line ; do
                check=`echo $line | grep "Error"`
                if [ ! -z "$check" ] ; then
                        name=`echo $line | awk '{ print $2 }'`
                        echo "Resyncing project=$name"
                        repo sync $name > output.txt 2>&1
                        check=`cat output.txt | grep "From ssh:"`
                        if [ ! -z "$check" ] ; then
                                end=`cat output.txt  | grep "fatal"`
                                if [ -z "$end" ] ; then
                                        echo "Project= $name Status=Done" >> log.txt
                                else
                                        echo "Project= $name Status=Error" >> log.txt
                                fi
                        else
                                echo "Project= $name Status=Already Synced" >> log.txt
                        fi

                fi
        done < ./newlog.txt
        rm -f ./log.txt ./newlog.txt
fi

if [ -e "$FILE" ] ; then
    NPROJ=`cat $FILE | grep project | wc | awk '{ print $1}'`
    i=1
    while read line ; do
        PROJECT=`echo $line | grep "<project"`

        if [ ! -z  "$PROJECT" ] ; then
                name=$(grep -Po '(?<=name=")[^"]*' <<<$line )
                echo "Syncing project=$name  ($i/$NPROJ  $((100*i/$NPROJ))%)"
                repo sync $name > output.txt 2>&1
                check=`cat output.txt | grep "From ssh:"`
                if [ ! -z "$check" ] ; then
                        end=`cat output.txt  | grep "fatal"`
                        if [ -z "$end" ] ; then
                                echo "Project= $name Status=Done" >> log.txt
                        else
                                echo "Project= $name Status=Error" >> log.txt
                        fi
                else
                        echo "Project= $name Status=Already Synced" >> log.txt
                fi
                i=$((i+1))
        fi
   done < $FILE
fi