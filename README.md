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

- Initialise dbt (This step is a one time execution. Hence skip this step as the repository already has dbt
  initialized.)

```shell
dbt init learn-dbt
```
