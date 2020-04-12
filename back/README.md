# MyPWA backend

## Setup

Use ruby version `2.6.3`. Check `.ruby-version` file for actual supported version

If you use RVM, you can run:
```sh
$ rvm use ruby-2.6.3@mypwa --create
```

Run bundle install:
```sh
$ bundle install
```

Copy and edit config files from examples:
```sh
$ cp .env.development-sample .env.development
$ cp .env.test-sample .env.test
```

Create database:

```sh
$ bundle exec rake db:create db:schema:load
```

## Testing


End to end testing:

In the directory with the client app please execute
```sh
$ npx vue-cli-service serve --mode test --port 8081
```

After that you can run feature specs:

```sh
$ bundle exec rspec spec/features
```
