#!/bin/bash
PROJECT_NAME=$(grep "project_name =" params.ninja | cut -d'=' -f2 | tr -d ' ')
DIST_DIR=$(grep "dist_dir =" params.ninja | cut -d'=' -f2 | tr -d ' ')

CUR_REV=$(svn info --show-item revision)

mkdir -p team_builds

echo "Начинаем сборку предыдущих ревизий..."

for i in 1 2 3; do
    REV=$((CUR_REV - i))
    if [ $REV -lt 1 ]; then continue; fi
    
    echo "--- Обработка ревизии $REV ---"
    svn update -r $REV --quiet
    
    ninja -t clean
    
    if ninja build; then
        echo "Сборка ревизии $REV прошла успешно."
        cp "$DIST_DIR/$PROJECT_NAME.jar" "team_builds/rev_$REV.jar"
    else
        echo "Ошибка сборки ревизии $REV"
    fi
done

echo "Возврат к исходной ревизии $CUR_REV..."
svn update -r $CUR_REV --quiet

if [ "$(ls -A team_builds)" ]; then
    zip -j "$DIST_DIR/team_builds.zip" team_builds/*.jar
    echo "Все версии упакованы в $DIST_DIR/team_builds.zip"
else
    echo "Нечего упаковывать."
fi

rm -rf team_builds