#import <React/RCTBridgeModule.h>
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(SalesforceChatSdk, RCTEventEmitter)

RCT_EXTERN_METHOD(startChat:(NSDictionary)chatConfig withDisplayConfig:(NSDictionary)displayConfig
                  withBackgroundConfig:(NSDictionary)backgroundConfig
                  withPreChatDatas:(NSArray)preChatDatas
                  withPrechatEntitiesData:(NSArray)prechatEntitiesData
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(setAppearance:(NSDictionary)appearanceConfig
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(closeChat:(RCTPromiseResolveBlock)resolve
				  withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

@end
