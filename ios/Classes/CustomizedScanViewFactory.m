//
//  CustomizedScanViewFactory.m

#import <Foundation/Foundation.h>
#import "CustomizedScanViewFactory.h"
#import "CustomizedScanView.h"

@implementation CustomizedScanViewFactory{
  NSObject<FlutterBinaryMessenger>*_messenger;
}
 
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager{
  self = [super init];
  if (self) {
    _messenger = messager;
  }
  return self;
}
 
-(NSObject<FlutterMessageCodec> *)createArgsCodec{
  return [FlutterStandardMessageCodec sharedInstance];
}
 
// 创建原生视图封装实例
-(NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args{
  CustomizedScanView *activity = [[CustomizedScanView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
  return activity;
}
@end
