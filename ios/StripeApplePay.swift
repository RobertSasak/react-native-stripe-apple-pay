@objc(StripeApplePay)
class StripeApplePay: NSObject {

  @objc(multiply:withB:withResolver:withRejecter:)
  func multiply(
    a: Float,
    b: Float,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) {
    resolve(a * b)
  }

  @objc(pay:withCountry:withCurrency:withResolver:withRejecter:)
  func pay(
    merchantIdentifier: String,
    country: String,
    currency: String,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) {
    resolve(merchantIdentifier + " " + country + " " + currency)
  }
}
