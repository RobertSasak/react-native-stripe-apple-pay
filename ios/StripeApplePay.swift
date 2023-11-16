import Foundation
import PassKit
import StripeApplePay

@objc(StripeApplePay)
class StripeApplePay: NSObject, ApplePayContextDelegate {

  var clientSecret: String? = nil
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

  @objc(
    pay:withClientSecret:withMerchantIdentifier:withCountry:withCurrency:withResolver:withRejecter:
  )
  func pay(
    publishableKey: String,
    clientSecret: String,
    merchantIdentifier: String,
    country: String,
    currency: String,
    resolve: @escaping RCTPromiseResolveBlock,
    reject: @escaping RCTPromiseRejectBlock
  ) {
    StripeAPI.defaultPublishableKey = publishableKey

    self.clientSecret = clientSecret
    self.resolve = resolve
    self.reject = reject

    let pr = StripeAPI.paymentRequest(
      withMerchantIdentifier: merchantIdentifier, country: country,
      currency: currency)

    pr.requiredBillingContactFields = []
    pr.paymentSummaryItems = [
      PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "29.99"))
    ]

    let applePayContext = STPApplePayContext(paymentRequest: pr, delegate: self)
    applePayContext?.presentApplePay()
  }

  public func applePayContext(
    _ context: STPApplePayContext,
    didCreatePaymentMethod paymentMethod: StripeCore.StripeAPI.PaymentMethod,
    paymentInformation: PKPayment, completion: @escaping STPIntentClientSecretCompletionBlock
  ) {
    completion(clientSecret, nil)
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
