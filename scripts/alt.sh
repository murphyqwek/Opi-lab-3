#!/bin/bash

MAPPING_FILE="alt_names.txt"

if [ ! -f "$MAPPING_FILE" ]; then
    echo "Файл $MAPPING_FILE не найден!"
    exit 1
fi

echo "Начинаем массовую замену имен..."

while IFS=: read -r old_name new_name; do
    if [ -z "$old_name" ]; then continue; fi

    echo "Замена: $old_name -> $new_name"

    find src/main/java -type f -name "*.java" -exec sed -i "s/\b$old_name\b/$new_name/g" {} +

    find src/main/java -type f -name "${old_name}.java" | while read -r file; do
        dir=$(dirname "$file")
        mv "$file" "$dir/${new_name}.java"
    done

done < "$MAPPING_FILE"

echo "Запукаю сборку альтернативной версии..."
ninja build