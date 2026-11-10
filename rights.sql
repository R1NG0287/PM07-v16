-- Учебный SQL настройки прав для варианта 16.
-- Пароли указаны как обозначения OWN_PASSWORD и должны быть заменены
-- на реальные учебные значения перед выполнением.

-- Создание ролей (выполняется от начального администратора сервера)
CREATE ROLE admin    LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE PASSWORD 'ADMIN_PASSWORD';
CREATE ROLE app_user LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE PASSWORD 'APP_PASSWORD';
CREATE ROLE readonly LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE PASSWORD 'READ_PASSWORD';

-- Создание баз
CREATE DATABASE pm07_v16         OWNER admin TEMPLATE template0 ENCODING 'UTF8';
CREATE DATABASE pm07_v16_restore OWNER admin TEMPLATE template0 ENCODING 'UTF8';

-- Права на схему и таблицы (выполняется от admin в pm07_v16)
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO app_user, readonly;
GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA public TO app_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;

-- Права на будущие таблицы
ALTER DEFAULT PRIVILEGES FOR ROLE admin IN SCHEMA public
  GRANT SELECT,INSERT,UPDATE,DELETE ON TABLES TO app_user;
ALTER DEFAULT PRIVILEGES FOR ROLE admin IN SCHEMA public
  GRANT SELECT ON TABLES TO readonly;
