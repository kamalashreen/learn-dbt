# learn-dbt

## Setup:

- Install dbt-core in python virtual env ([Ref](https://docs.getdbt.com/docs/core/pip-install))

```shell
python3 -m venv dbt-env
source dbt-env/bin/activate
# With just dbt-core, CLI is not available
python -m pip install dbt-core
# Install dbt-core along with an adaptor, for e.g. dbt-postgres
python -m pip install dbt-postgres
```

- Initialize dbt (This step is a one time execution. Hence skip this step as the repository already has dbt
  initialized.)

```shell
dbt init learn-dbt
```

- Setting up a postgresql server on local:

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