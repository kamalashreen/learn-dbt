# Postgresql database setup

- Create sample database

```psql
CREATE DATABASE analytics; 
```

- Create new user specifically for dbt

```psql
CREATE USER transform_role with
	PASSWORD 'postgres'
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	NOINHERIT
	LOGIN
	NOREPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1;
```

- Login as a postgres user and grant priviliges for transform_role to analytics database and its public schema.

```psql
GRANT CREATE ON database analytics TO transform_role;

ALTER DEFAULT PRIVILEGES FOR ROLE transform_role
    GRANT USAGE ON SCHEMAS TO transform_role;

ALTER DEFAULT PRIVILEGES FOR ROLE transform_role
    GRANT SELECT ON tables TO transform_role;
```

- Create a sample table within `learn_dbt` database

```psql
CREATE TABLE public.learn_dbt (
	column1 int4 GENERATED ALWAYS AS IDENTITY NOT NULL,
	column2 varchar NOT NULL,
	CONSTRAINT learn_dbt_pk PRIMARY KEY (column1)
);
```