#!/bin/sh
set -e

WORKSPACE=${WORKSPACE:-/workspace}
CHANGE_OWNER=${CHANGE_OWNER:-0}

if [ "$USERID" -gt 0 -o "$GROUPID" -gt 0 ]
then                  
        ORIGPASSWD=$(cat /etc/passwd | grep c9)
        ORIG_UID=$(echo $ORIGPASSWD | cut -f3 -d:)
        ORIG_GID=$(echo $ORIGPASSWD | cut -f4 -d:)
                                                                                
        if [ $USERID -ne $ORIG_UID ] || [ $GROUPID -ne $ORIG_GID ] \
        || [ $USERID -ne  $(ls -rn /workspace | awk 'NR==2 {print $3 }') ] \
        || [ $GROUPID -ne  $(ls -rn /workspace | awk 'NR==2 {print $4 }') ]
        then
                sed -i -e "s/:$ORIG_UID:$ORIG_GID:/:$USERID:$GROUPID:/" /etc/passwd
                sed -i -e "s/c9:x:$ORIG_GID:/c9:x:$GROUPID:/" /etc/group          
                ORIG_HOME=$(echo $ORIGPASSWD | cut -f6 -d:)                
                chown -R c9:c9 $ORIG_HOME
                
                if [ $CHANGE_OWNER -gt 0 ]
                then 
                        chown -R c9:c9 /workspace
                fi
        fi                                                  
fi

su c9 -c "/usr/bin/node /home/c9/.c9/server.js -l 0.0.0.0 -p 8000 -w $WORKSPACE -a $USERNAME:$PASSWORD"
