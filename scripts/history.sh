#!/bin/bash
REVISION=$(svn info --show-item revision)
while ! ninja compile; do
    REVISION=$((REVISION-1))
    echo "Сборка упала. Пробуем ревизию $REVISION..."
    svn update -r $REVISION
    if [ $REVISION -le 1 ]; then
        echo "Достигнута первая ревизия. Генерация diff..."
        svn diff -c $((REVISION+1)) > failure_diff.patch
        exit 1
    fi
done