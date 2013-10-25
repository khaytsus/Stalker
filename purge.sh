#!/bin/sh

defaultdays=90
date=`date +%m-%d-%Y_%-H%M`

case $1 in
    ''|*[!0-9]*)
        days=$defaultdays ;;
    *)  
        days=$1 ;;
esac

echo "This script will take a while to run and will likely make your irc"
echo "connections time out.  If you want to stop the stalker script in irssi,"
echo -n "do so now and hit enter when ready.."
read $foo

echo ""
echo -n "Starting delete and vacuum for last ${days} days...  "

cp nicks.db nicks-${date}.db

sqlite3 nicks.db \
  "delete from records where added < date('now','-${days} days'); vacuum;"

echo "Done"
