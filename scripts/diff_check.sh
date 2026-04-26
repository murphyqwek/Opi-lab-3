#!/bin/bash
SENSITIVE=$(grep "sensitive_classes =" params.ninja | cut -d'=' -f2)
CHANGES=$(svn status | awk '{print $2}')
BLOCK=false
for f in $CHANGES; do
    for s in $SENSITIVE; do
        if [[ "$f" == *"$s"* ]]; then BLOCK=true; fi
    done
done
if [ "$BLOCK" = false ]; then svn commit -m "Auto-commit via diff target"; else echo "Commit blocked!"; fi