### Using the DBT project
1. Setup dbt environment:
Assuming python has been setup locally, create a virtual env
```shell
virtualenv dbt-databricks-env
source dbt-databricks-env/bin/activate
```
2. Install databricks adapter for dbt, this will also install dbt-core
```shell
pip install dbt-databricks
```
3. In VS Code Select the Python Interpreter (`CTRL+SHIFT+P`)
4. Run dbt debug to make sure your connection is working
```shell
dbt debug
```
5. Next, try running the following commands:
```shell
dbt compile
dbt run
dbt test
```

### DBT Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
