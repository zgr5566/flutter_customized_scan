#import "FlutterCustomizedScanPlugin.h"
#import "CustomizedScanViewFactory.h"

@implementation FlutterCustomizedScanPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"flutter_customized_scan"binaryMessenger:[registrar messenger]];
  FlutterCustomizedScanPlugin* instance = [[FlutterCustomizedScanPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
    
    CustomizedScanViewFactory *viewFactory = [[CustomizedScanViewFactory alloc] initWithMessenger:registrar.messenger];

    [registrar registerViewFactory:viewFactory withId:@"CustomizedScanView"];
  
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
