#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(StripeApplePay, NSObject)

RCT_EXTERN_METHOD(multiply:(float)a 
                 withB:(float)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(pay:(NSString *)merchantIdentifier 
                 withCountry:(NSString *)country 
                 withCurrency:(NSString *)currency
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
