import * as React from 'react';

import { StyleSheet, View, Text, Button } from 'react-native';
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
        onPress={() =>
          pay('merchant.com.app', 'NO', 'NOK')
            .then(console.warn)
            .catch(console.warn)
        }
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
