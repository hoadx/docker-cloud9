#!/bin/sh
set -e

if [ \("$USER_ID" > 0\) -o \("$GROUP_ID" > 0\) ]
then                  
        ORIGPASSWD=$(cat /etc/passwd | grep c9)
        ORIG_UID=$(echo $ORIGPASSWD | cut -f3 -d:)
        ORIG_GID=$(echo $ORIGPASSWD | cut -f4 -d:)
                                                                                
        if [ \("$USER_ID" != "$ORIG_UID"\) -o \("$GROUP_ID" != "$ORIG_GID"\) ]; then
                sed -i -e "s/:$ORIG_UID:$ORIG_GID:/:$USER_ID:$GROUP_ID:/" /etc/passwd
                sed -i -e "s/c9:x:$ORIG_GID:/c9:x:$GROUP_ID:/" /etc/group          
                ORIG_HOME=$(echo $ORIGPASSWD | cut -f6 -d:)                
                chown -R c9:c9 ${ORIG_HOME}
                if test $CHANGE_OWNER -gt 0
                then 
                        chown -R c9:c9 /workspace
                fi
        fi                                                  
fi

su - c9 -c "/usr/bin/node /home/c9/.c9/server.js -l 0.0.0.0 -p 8000 -w /workspace -a $USERNAME:$PASSWORD"
