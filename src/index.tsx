import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-stripe-apple-pay' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const StripeApplePay = NativeModules.StripeApplePay
  ? NativeModules.StripeApplePay
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function pay(
  publishableKey: String,
  clientSecret: String,
  merchantIdentifier: string,
  country: string,
  currency: string,
  amount: string
): Promise<string> {
  return StripeApplePay.pay(
    publishableKey,
    clientSecret,
    merchantIdentifier,
    country,
    currency,
    amount
  );
}
