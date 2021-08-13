
#ifndef CustomizedScanViewFactory_h
#define CustomizedScanViewFactory_h
#import <Flutter/Flutter.h>

@interface CustomizedScanViewFactory : NSObject<FlutterPlatformViewFactory>
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messager;
@end

#endif /* CustomizedScanViewFactory_h */
