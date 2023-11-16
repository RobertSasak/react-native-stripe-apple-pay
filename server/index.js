const express = require('express');
const app = express();

const port = 5464;
const secretKey = process.env.SECRET_KEY;
const publishableKey = process.env.PUBLISHABLE_KEY;
const merchantIdentifier = 'merchant.com.example';
const country = 'US';
const currency = 'USD';
const amount = 100;

if (!secretKey) {
  const error =
    'You must set the SECRET_KEY environment variable.\nexport SECRET_KEY=<your publishable key>\nor\nSECRET_KEY=<your publishable key> yarn start';
  console.error(error);
  throw new Error(error);
}

if (!publishableKey) {
  const error =
    'You must set the PUBLISHABLE_KEY environment variable.\nexport PUBLISHABLE_KEY=<your publishable key>\nor\nPUBLISHABLE_KEY=<your publishable key> yarn start';
  console.error(error);
  throw new Error(error);
}

const stripe = require('stripe')(secretKey);

app.post('/create-payment-intent', async (req, res) => {
  const paymentIntent = await stripe.paymentIntents.create({
    amount,
    currency,
  });

  res.send({
    publishableKey,
    merchantIdentifier,
    clientSecret: paymentIntent.client_secret,
    country,
    currency,
    amount: `${amount / 100}`,
  });
  console.log('Payment intent created');
});

// To get a confirmation register a webhook in Stripe dashboard.
// app.post('/webhook', async (req, res) => {});

app.listen(port, () => console.log(`Node server listening on port ${port}`));
