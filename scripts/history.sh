#!/bin/bash
ORIGINAL_REV=$(svn info --show-item revision)
CUR_REV=$ORIGINAL_REV

while true; do
    # Очищаем старые артефакты перед каждой попыткой
    ninja clean > /dev/null 2>&1
    
    if ninja compile; then
        echo "Рабочая ревизия найдена: $CUR_REV"
        break
    fi

    CUR_REV=$((CUR_REV - 1))
    if [ $CUR_REV -lt 1 ]; then
        echo "Достигнута первая ревизия. Генерация diff..."
        # Генерируем diff между первой и той, что была после неё
        svn diff -r 1:$((CUR_REV+2)) > breaking_changes.patch
        exit 0
    fi
    
    echo "Сборка упала. Пробуем ревизию $CUR_REV..."
    svn update -r $CUR_REV --quiet
done

if [ $CUR_REV -lt $ORIGINAL_REV ]; then
    svn diff -c $((CUR_REV+1)) > breaking_changes.patch
fi