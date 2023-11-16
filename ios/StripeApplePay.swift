@objc(StripeApplePay)
class StripeApplePay: NSObject {

  @objc(multiply:withB:withResolver:withRejecter:)
  func multiply(a: Float, b: Float, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock)
  {
    resolve(a * b)
  }

  @objc(pay:withB:withResolver:withRejecter:)
  func pay(a: Float, b: Float, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
    resolve(a * b)
  }
}
