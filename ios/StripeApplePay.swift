import Foundation
import PassKit
import StripeApplePay

@objc(StripeApplePay)
class StripeApplePay: NSObject, ApplePayContextDelegate {

  var resolve: RCTPromiseResolveBlock? = nil
  var reject: RCTPromiseRejectBlock? = nil

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
    resolve: @escaping RCTPromiseResolveBlock,
    reject: @escaping RCTPromiseRejectBlock
  ) {
    StripeAPI.defaultPublishableKey = "pk_test_5"
              
    self.resolve = resolve
    self.reject = reject

    let pr = StripeAPI.paymentRequest(
      withMerchantIdentifier: merchantIdentifier, country: country,
      currency: currency)

    // You'd generally want to configure at least `.postalAddress` here.
    // We don't require anything here, as we don't want to enter an address
    // in CI.
    pr.requiredShippingContactFields = []
    pr.requiredBillingContactFields = []

    // Configure shipping methods
    let firstClassShipping = PKShippingMethod(
      label: "First Class Mail", amount: NSDecimalNumber(string: "10.99"))
    firstClassShipping.detail = "Arrives in 3-5 days"
    firstClassShipping.identifier = "firstclass"
    let rocketRidesShipping = PKShippingMethod(
      label: "Rocket Rides courier", amount: NSDecimalNumber(string: "10.99"))
    rocketRidesShipping.detail = "Arrives in 1-2 hours"
    rocketRidesShipping.identifier = "rocketrides"
    pr.shippingMethods = [
      firstClassShipping,
      rocketRidesShipping,
    ]

    // Build payment summary items
    // (You'll generally want to configure these based on the selected address and shipping method.
    pr.paymentSummaryItems = [
      PKPaymentSummaryItem(label: "A very nice computer", amount: NSDecimalNumber(string: "19.99")),
      PKPaymentSummaryItem(label: "Shipping", amount: NSDecimalNumber(string: "10.99")),
      PKPaymentSummaryItem(label: "Stripe Computer Shop", amount: NSDecimalNumber(string: "29.99")),
    ]

    // Present the Apple Pay Context:
    let applePayContext = STPApplePayContext(paymentRequest: pr, delegate: self)
    applePayContext?.presentApplePay()
  }

  public func applePayContext(
    _ context: STPApplePayContext,
    didCreatePaymentMethod paymentMethod: StripeCore.StripeAPI.PaymentMethod,
    paymentInformation: PKPayment, completion: @escaping STPIntentClientSecretCompletionBlock
  ) {
    resolve!("done")
  }

  public func applePayContext(
    _ context: STPApplePayContext, didCompleteWith status: STPApplePayContext.PaymentStatus,
    error: Error?
  ) {
    switch status {
    case .success:
      resolve!("success")
      break
    case .error:
      reject!(error?.localizedDescription, error.debugDescription, nil)
      break
    case .userCancellation:
      reject!("cancelled-by-user", "Payment cancelled by user", nil)
      break
    }
  }

}
