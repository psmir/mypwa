# MyPWA frontend

## Project setup

Expected Node version ">= 10.*"

```sh
$ yarn install
```

## Start

```sh
$ npx vue-cli-service serve --mode development --port 8080
```


## Access from a device locally

In the frontend directory start rails server like this:

```sh
$ rails s -b 0.0.0.0
```

Then edit .env.development (set your local ip there)

VUE_APP_SERVER_URL=http://192.168.1.65:3000
VUE_APP_ACTIONCABLE_URL=ws://192.168.1.65:3000/cable

Then run:

```sh
$ npx vue-cli-service serve --mode development --port 8080
```

And you can access the app with your device
http://192.168.1.65:8080
