#!/bin/sh
#
# Install Script
#


# User Defined variables
weburl="https://ltpsmdmresources.blob.core.windows.net/mac-apps/LTechAgent.zip"
app="LabTech for Mac"
appname="KyosLabTech"
KyosTempdir=/tmp/KyosSources
                                                  

waitForProcess () {

    processName=$1
    fixedDelay=$2
    terminate=$3

    echo "$(date) | Waiting for other [$processName] processes to end"
    while ps aux | grep "$processName" | grep -v grep &>/dev/null; do

        if [[ $terminate == "true" ]]; then
            echo "$(date) | + [$appname] running, terminating [$processpath]..."
            pkill -f "$processName"
            return
        fi

        # If we've been passed a delay we should use it, otherwise we'll create a random delay each run
        if [[ ! $fixedDelay ]]; then
            delay=$(( $RANDOM % 50 + 10 ))
        else
            delay=$fixedDelay
        fi

        echo "$(date) |  + Another instance of $processName is running, waiting [$delay] seconds"
        sleep $delay
    done
    
    echo "$(date) | No instances of [$processName] found, safe to proceed"
}


function downloadApp () {

    #download the file
    # rm -r $tempdir 
    if [[ $KyosTempdir == "true" ]]; then
	cd $KyosTempdir
        curl -f -s --connect-timeout 30 --retry 5 --retry-delay 60 -L -J -O "$weburl" --output /tmp/KyosSources/LTechAgent.zip
    else
        mkdir $KyosTempdir
	cd $KyosTempdir
        curl -f -s --connect-timeout 30 --retry 5 --retry-delay 60 -L -J -O "$weburl" --output /tmp/KyosSources/LTechAgent.zip
    fi
}


## Install Function
function installApp () {
  # wait for other downloads to complete
  waitForProcess "curl -f"

  cd "$KyosTempdir"
  unzip LTechAgent.zip
  installer -pkg LTSvc.mpkg -target /
}


#
# Install
#

downloadApp
installApp