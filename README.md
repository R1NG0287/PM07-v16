# PM.07 — Учебная практика, вариант 16

Предметная область: Ветеринарная клиника
СУБД: PostgreSQL 16.15
ОС: Debian 13 (Trixie) внутри WSL2 на Windows 11
Маршрут: PostgreSQL 15/16 · Linux

## Назначение файлов

- input.sql — исходный SQL варианта 16: три предметные таблицы (animals, owners, visits) и access_probe
- rights.sql — SQL создания ролей (admin, app_user, readonly) и настройки прав с учебными обозначениями вместо паролей
- run.sh — каркас маршрута с встроенной функцией run_task варианта 16 и индивидуальным дополнением (вычисление SHA-256 архива)
- config.env.example — пример конфигурации с параметрами подключения без пароля

## Команда ручного запуска

    cd $HOME/pm07
    bash ./run.sh
    echo $?
    tail -n 8 logs/run.log

Ожидаемый результат: код 0, в журнале строки START, partial_archive, sha256, END result=OK.

## Параметры config.env

- DB = pm07_v16
- DB_HOST = 127.0.0.1
- DB_PORT = 5432
- CLIENT = psql
- DUMP = pg_dump
- AUTH = $WORK/auth/pgpass (парольный профиль, не включается в репозиторий)
- AS_OF = 2026-11-04 (учебная дата отсчёта)

## Парольный профиль auth/pgpass

Формат файла .pgpass:

    127.0.0.1:5432:pm07_v16:admin:OWN_PASSWORD

Права: chmod 600 auth/pgpass. Файл НЕ включается в репозиторий.

## Периодичность cron

Постоянное расписание — ежедневный запуск в 03:00:

    0 3 * * * /bin/bash "$HOME/pm07/run.sh" >> "$HOME/pm07/logs/cron.log" 2>&1

## Расположение журнала

logs/run.log — фиксирует START, partial_archive, sha256, END, ERROR.

## Ожидаемый результат операции

В папке backups/ создаётся частичный архив pm07_v16_animals_visits_STAMP.dump (только таблицы animals и visits), оглавление .toc.txt и файл .sha256 с контрольной суммой архива.
