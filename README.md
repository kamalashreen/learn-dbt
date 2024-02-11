# learn-dbt

## Setup:

1. Install dbt-core in python virtual env ([Ref](https://docs.getdbt.com/docs/core/pip-install))

   ```shell
   python3 -m venv dbt-env
   source dbt-env/bin/activate
   # With just dbt-core, CLI is not available
   python -m pip install dbt-core
   # Install dbt-core along with an adaptor, for e.g. dbt-postgres
   python -m pip install dbt-postgres
   ```

2. Initialize dbt (This step is a one time execution. Hence skip this step as the repository already has dbt
   initialized.)

    ```shell
    dbt init learn_dbt
    ```

3. Setting up a postgresql server on local:

    ```shell
    # To pull latest postgres image
    docker pull postgres
    # To pull specific version of postgres image
    docker pull postgres:15.5
    # Create a local docker network
    docker network create -d bridge some-network
    # Run local postgres server
    docker run --name some-postgres --network some-network -p 5432:5432 -e POSTGRES_PASSWORD=some-password -d postgres
    # Verify if the server is up successfully by running below command
    docker exec some-postgres /bin/bash -c "PGPASSWORD=some-password psql -h localhost -U postgres -c 'SELECT 1;'"
    # You should see an output such as
    #  ?column?
    #----------
    #        1
    #(1 row)
    ```

4. Follow steps mentioned in [setup-postgres-database.md](setup-postgres-database.md) to complete the database setup.

5. Configure dbt profiles
    - Run `dbt debug --config-dir` to find the directory containing dbt profiles configuration. Path is
      generally `~/.dbt/profiles.yml`.
    - The pre-generated profiles.yml should look something like below and update the required details as mentioned:

   ```yaml
   # Name the dbt profile with any name of your choice
   # I've named my dbt profile learn_dbt_postgres
   learn_dbt_postgres:
    outputs:
      dev:
        # The database that dbt needs to connect to, in this case, the database that we created in the previous step
        dbname: analytics
        # Postgres server
        host: localhost
        # Postgres password
        pass: some-password
        port: 5432
        # The database schema that dbt needs to use
        schema: dbt
        threads: 1
        # The type of the account you have, for e.g., snowflake
        type: postgres
        # The user that dbt needs to use to connect to postgres, in this case, the user that we created in previous step
        user: transform_role
    # Target needs to be dev
    target: dev
   ```

6. Configure dbt_project.yml under the dbt project we initialized in Step 2. NOTE: Only fields that are to be updated
   are mentioned below.

   ```yaml
      # Name the dbt project with any name of your choice
      name: 'learn_dbt'

      # Update the name of the profile to be same as the profile name we mentioned in `~/.dbt/profiles.yml`
      profile: 'learn_dbt_postgres'

      models:
        # Name the model to be same as the project name you mentioned above
        learn_dbt:
          example:
            +materialized: view
   ```

7. Verify that the configuration and dependencies are correct and connection from dbt to postgres database is
   successful.

   ```shell
   dbt debug
   ```

8. To successfully execute the SQL queries specified in dbt models, you would need to grant appropriate privileges to
   your database, schemas and tables. The privileges we've granted as part of Step 4 should be sufficient to run the
   initial set of queries. Run below command to execute the SQL queries.

   ```shell
   dbt run
   ```

9. You should now be able to see a table named `my_first_dbt_model` and a view named `my_second_dbt_model` created in
   your database schema. Verify by running below queries:

   ```psql
   SELECT * FROM analytics.dbt.my_first_dbt_model mfdm;
   SELECT * FROM analytics.dbt.my_second_dbt_model msdm;
   ```
