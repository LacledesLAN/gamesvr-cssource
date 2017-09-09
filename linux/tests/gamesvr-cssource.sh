#!/bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
logfile="$scriptdir/gamesvr-cssource.log"

echo $'\n\n{{ TESTING VANILLA CS:SOURCE SERVER }}';

if [ -f "$scriptdir/../srcds_run" ]; then
    echo $'\tAttemping to run server for 45 seconds to capture output';
    command="$scriptdir/../srcds_run -game cstrike -tickrate 100 +map de_dust2 -console -usercon +sv_lan 1"
    $command > "$logfile" 2>&1 &
    pid=$!
    sleep 45
    #kill $pid NOT NEEDED IN DOCKER BUT SHOULD BE FLUSHED OUT; WOULD ALLOW USAGE OUTSIDE CONAINTER CONTEXT
else
    #command="docker run -it --rm --net=host test ./srcds_run -game cstrike -tickrate 100 +map de_dust2 -console -usercon +sv_lan 1"
    echo "srcds_run not found!";
    echo "This script only works inside of the docker container";
    exit 1;
fi

#      ____                _           ______             __
#     / __ ) ___   ____ _ (_)____     /_  __/___   _____ / /_ _____
#    / __  |/ _ \ / __ `// // __ \     / /  / _ \ / ___// __// ___/
#   / /_/ //  __// /_/ // // / / /    / /  /  __/(__  )/ /_ (__  )
#  /_____/ \___/ \__, //_//_/ /_/    /_/   \___//____/ \__//____/
#               /____/

# Make sure server started executing
if ! grep -i -q "Server will auto-restart if there is a crash" "$logfile"; then
    echo $'\tFAIL: Server did start to execute';
    exit 1;
else
    echo $'\tPASS: Server started executing';
fi;

# Make sure server isn't boot-looping
if grep -i -q "Server restart in 10 seconds" "$logfile"; then
    echo $'\tFAIL: Server is boot-looping';
    exit 1;
else
    echo $'\tPASS: Server is not boot looping';
fi;

# Make sure server didn't run under user 'root'
if grep -i -q "Running the dedicated server as root" "$logfile"; then
    echo $'\tFAIL: Server ran under root account';
    exit 1;
else
    echo $'\tPASS: Server did not run under user root';
fi;

#Make sure srcds_run is executing CS:SOURCE (and not another title)
if ! grep -i -q "server_srv.so loaded for \"Counter-Strike: Source\"" "$logfile"; then
    echo $'\tFAIL: Server is not running gametype CS:SOURCE';
    exit 1;
else
    echo $'\tPASS: Server is running CS:SOURCE';
fi;

# Make sure server hibernated
if ! grep -i -q "Server is hibernating" "$logfile"; then
    echo $'\tFAIL: Server did not hibernate';
    exit 1;
else
    echo $'\tPASS: Server succesfully hibernated';
fi;

echo $'{{ ALL TESTS PASSED}}\n\n';

exit 0;