# react-native-stripe-apple-pay

React Native wrapper around Stripe Apple Pay. Currently there are very limited configuration options. Feel free to open a PR to add more.

## Installation

```sh
yarn add install react-native-stripe-apple-pay
```

## Testing

Before including this library in your project you can test it by running the example app and example server.

### Install dependencies

```sh
yarn
```

### Run server

```sh
export SECRET_KEY=sk_test_...
export PUBLISHABLE_KEY=pk_test_...
yarn server
# or
SECRET_KEY=sk_test_... PUBLISHABLE_KEY=pk_test_... yarn server
```

### Run example app

```sh
yarn example ios
# or select a simulator
yarn example ios --simulator "iPhone 15 Pro Max"
```

## Usage

See example and server folder.

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
