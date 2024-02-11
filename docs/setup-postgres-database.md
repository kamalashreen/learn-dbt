# Postgresql database setup

1. Create sample database

    ```psql
    CREATE DATABASE analytics;
    ```

2. Create new user specifically for dbt

    ```psql
    CREATE USER transform_role with
        PASSWORD 'some-password'
        NOSUPERUSER
        NOCREATEDB
        NOCREATEROLE
        NOINHERIT
        LOGIN
        NOREPLICATION
        NOBYPASSRLS
        CONNECTION LIMIT -1;
    ```

3. Login as a postgres user and grant privileges for transform_role to analytics database and its public schema.

    ```psql
    GRANT CREATE ON database analytics TO transform_role;

    ALTER DEFAULT PRIVILEGES FOR ROLE transform_role
        GRANT USAGE ON SCHEMAS TO transform_role;

    ALTER DEFAULT PRIVILEGES FOR ROLE transform_role
        GRANT SELECT ON tables TO transform_role;
    ```
