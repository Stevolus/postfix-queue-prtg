#!/bin/bash

# Description: Outputs the current postfix mail queue in a format recognised by PRTG server.
# Author: Steven Marchant
# Notes: Below is pretty self explainatary. You can change the values of mails in the
#        queue next to the queuelength if statements as you see fit, for the desired message to be displayed.
#        First if statement is if there are no mails in the queue, then normal amount of mails, then warning, then critical.
#        The messages for each can also be altered as you desire.

queuelength=`/usr/sbin/postqueue -p | tail -n1 | awk '{print $5}'`
queuecount=`echo $queuelength | grep "[0-9]"`

if [ "$queuelength" == "" ]; then
         status=0 queuelength=0 message="There are no mails in the queue";

elif [ "$queuelength" -le "25000" ]; then
         status=0 message="All good, acceptable mail load";

elif [ "$queuelength" -ge "25000" ]; then
         status=1 message="Heavy mail usage, keep a close eye";

elif [ "$queuelength" -ge "50000" ]; then
         status=2 message="Extremely high mail usage. Check logs for details";

fi

        echo $status:$queuelength:$message;


exit