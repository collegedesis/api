## Contributing

The more the merrier. Take a look at [open issues](../../issues).

### Setting up locally

[Install Ruby](http://getrvm.io), [PostgreSQL](//www.postgresql.org)
(see below for PostgreSQL role config), and [Elasticsearch](http://www.elasticsearch.org/).
Start the Elasticsearch server and then:

```
git clone git@github.com:collegedesis/api
rake db:setup
rake db:seed_dev
rails s
```

### Postgres setup

To use the settings currently in `config/database.yml`, follow these steps:

1. `brew install postgres`
1. Start the postgres server
1. Create a role named `collegedesis`
  1. From CLI `createuser collegedesis`
1. Grant that role the ability to create databases
  1. Inside `psql`: `alter user collegedesis with createdb`
