#!/bin/bash
CP=$1; RUNNER=$2; FILE="report.xml"
OUTPUT=$(java -cp "$CP" $RUNNER 2>&1)
echo "<?xml version='1.0' encoding='UTF-8'?><testsuite name='NinjaTests'><testcase classname='$RUNNER' name='all'><system-out><![CDATA[$OUTPUT]]></system-out></testcase></testsuite>" > $FILE
git add $FILE && git commit -m "Auto-report $FILE"