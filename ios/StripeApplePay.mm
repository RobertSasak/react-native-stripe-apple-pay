#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(StripeApplePay, NSObject)

RCT_EXTERN_METHOD(pay:(NSString *)publishableKey 
                 withClientSecret:(NSString *)clientSecret 
                 withMerchantIdentifier:(NSString *)merchantIdentifier 
                 withCountry:(NSString *)country 
                 withCurrency:(NSString *)currency
                 withAmount:(NSString *)amount
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
