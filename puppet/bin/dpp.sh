#!/bin/bash
if [ -e /usr/src/dpp/client ] ; then
    cd /usr/src/dpp/client
    /usr/bin/screen -dmS dpp ./dpp.pl &
else
    cd /home/xani/src/my/dpp/client 
    /usr/bin/screen -dmS dpp ./dpp.pl &
fi

