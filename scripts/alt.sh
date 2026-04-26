#!/bin/bash

MAPPING_FILE="alt_names.txt"

if [ ! -f "$MAPPING_FILE" ]; then
    echo "Файл $MAPPING_FILE не найден!"
    exit 1
fi

echo "Начинаем массовую замену имен..."

# Читаем файл построчно
while IFS=: read -r old_name new_name; do
    if [ -z "$old_name" ]; then continue; fi

    echo "Замена: $old_name -> $new_name"

    # 1. Заменяем текст внутри всех .java файлов
    # Используем \b для точного совпадения (чтобы не заменить Data в DataBean)
    find src/main/java -type f -name "*.java" -exec sed -i "s/\b$old_name\b/$new_name/g" {} +

    # 2. Переименовываем файлы, если имя файла совпадает с именем класса
    # Например: Point.java -> Location.java
    find src/main/java -type f -name "${old_name}.java" | while read -r file; do
        dir=$(dirname "$file")
        mv "$file" "$dir/${new_name}.java"
    done

done < "$MAPPING_FILE"

# 3. После всех замен вызываем сборку, как требует задание
echo "Запукаю сборку альтернативной версии..."
ninja build