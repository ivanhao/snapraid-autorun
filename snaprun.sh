#!/bin/bash
#----------------------------#
#Author: 龙天ivan            #
#----------------------------#
/usr/local/bin/snapraid diff>/tmp/diff 2>&1 
#cat /tmp/diff
diff=`grep differen /tmp/diff|awk '{print $1}'`
#eq=`grep equ /tmp/diff|awk '{print $1}'`
#rmv=`grep remove /tmp/diff|awk '{print $1}'`
#ad=`grep added /tmp/diff|awk '{print $1}'`
#echo $diff $eq $rmv $ad
case "$diff" in
    "No" )
        ;;
    "There" )
        #echo `grep added /tmp/diff|awk '{print $0}'`
        /usr/local/bin/snapraid sync>/tmp/sync
        /usr/local/bin/snapraid scrub>/tmp/scrub
        sync=`grep "Everything OK" /tmp/sync|wc -l`
        scrub=`grep "Nothing to do" /tmp/scrub|wc -l`
        case "$sync" in
            0 )
                cat /tmp/sync|mail -s "snapraid sync" root
                ;;
            1 )
                echo "sync done."
                ;;
        esac
        case "$scrub" in 
            0 )
                cat /tmp/scrub|mail -s "snapraid scrub" root
                ;;
            1 )
                echo "scrub done."
                ;;
        esac
esac
