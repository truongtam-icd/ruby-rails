# README

### Require:

```
ruby >= 3.1.4
gem >= 3.4.21
Rails >= 7.1.1
```

### How to run?

```
cd ~/project/ruby-rails
bundle exec rake db:create
bundle exec rake db:migrate RAILS_ENV="development"
bin/rails server -e development
```

### Localhost

```
http://localhost:3000
```

### How to install package gemfile

```
bundle install
```

### Unit test

```
bundle exec rake test
```

### Document:

* [Getting Started with Rails](https://guides.rubyonrails.org/getting_started.html)
* [Ruby on Rails Guides](https://guides.rubyonrails.org)
* [The API Documentation](https://api.rubyonrails.org)
* [Rake DB](https://viblo.asia/p/cac-lenh-rake-db-RQqKLzq4l7z)


# Docker
####  Create MySQL Local

- Build

```bash
docker-compose -f docker-compose.mysql.yml up -d --build
```

- Run

```bash
# Start SQL Server
docker-compose -f docker-compose.mysql.yml start

# Stop SQL Server
docker-compose -f docker-compose.mysql.yml stop
```

- Other

```bash
# Login to SQL Server
docker exec -it <CONTAINER ID> bash

# Check SQL Server log
docker-compose -f docker-compose.mysql.yml logs -f --tail=50
```