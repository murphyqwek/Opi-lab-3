#!/bin/bash
CUR_REV=$(svn info --show-item revision)
for i in {1..3}; do
    svn update -r $((CUR_REV-i))
    ninja build && cp target/dist/*.jar "target/dist/rev_$((CUR_REV-i)).jar"
done
svn update -r $CUR_REV
zip -j target/dist/team.zip target/dist/rev_*.jar