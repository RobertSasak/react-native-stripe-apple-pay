import * as React from 'react';

import { StyleSheet, View, Text, Button, Alert } from 'react-native';
import { multiply, pay } from 'react-native-stripe-apple-pay';

export default function App() {
  const [result, setResult] = React.useState<number | undefined>();

  React.useEffect(() => {
    multiply(3, 7).then(setResult);
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
      <Button
        onPress={async () => {
          // You need to get clientSecret from your server
          // However while doing that you can also get all the other constants and avoid hardcoding.
          try {
            const response = await fetch(
              `http://localhost:5464/create-payment-intent`,
              {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                  // feel free to send any extra data such as purchased items to help you calculate price
                }),
              }
            );
            const {
              publishableKey,
              clientSecret,
              merchantIdentifier,
              country,
              currency,
            } = await response.json();

            pay(
              publishableKey,
              clientSecret,
              merchantIdentifier,
              country,
              currency
            )
              .then(() => Alert.alert('Success'))
              .catch((error) => {
                console.warn(error);
                Alert.alert('Error', error.toString());
              });
          } catch (error) {
            Alert.alert(
              'Server error',
              'Remember to start the server by yarn server\n' + String(error)
            );
          }
        }}
        title="Pay with Apple Pay"
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
