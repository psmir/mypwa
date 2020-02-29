# Chatty

## Project setup
```
yarn install
```

### Compiles and hot-reloads for development
```
yarn run serve
```

### Compiles and minifies for production
```
yarn run build
```

### Run your tests
```
yarn run test
```

### Lints and fixes files
```
yarn run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

### Access from a device locally

Start rails server like this:

$ rails s -b 0.0.0.0

Then edit .env.development (set your local ip there)

VUE_APP_SERVER_URL=http://192.168.1.65:3000
VUE_APP_ACTIONCABLE_URL=ws://192.168.1.65:3000/cable

Then run:
$ npx vue-cli-service serve --mode development --port 8080

And you can access the app with your device
http://192.168.1.65:8080
