
#import <Foundation/Foundation.h>
#import "CustomizedScanView.h"

@implementation CustomizedScanView{
    FlutterMethodChannel *_channel;
}
    
// 创建原生视图
- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
  if ([super init]) {
      self.hmsCustomScanViewController = [[HmsCustomScanViewController alloc] init];
      self.hmsCustomScanViewController.customizedScanDelegate = self;
      // 返回按钮，若需要隐藏赋值为true。
      self.hmsCustomScanViewController.backButtonHidden = true;
      // 赋值true为持续扫码，默认为false非持续扫码。
      self.hmsCustomScanViewController.continuouslyScan = true;
      _channel = [FlutterMethodChannel methodChannelWithName:[NSString stringWithFormat:@"flutter_customized_scan_%lld", viewId] binaryMessenger:messenger];
      __weak __typeof__(self) weakSelf = self;
      [_channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
          [weakSelf onMethodCall:call result:result];
      }];
  }
  return self;
}
 
-(UIView *)view{
  return self.hmsCustomScanViewController.view;
}

- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    // 如果方法名完全匹配
}

- (void)customizedScanDelegateForResult:(NSDictionary *)resultDic{
  dispatch_async(dispatch_get_main_queue(), ^{
      // 在主线程内处理数据
      NSString *result = resultDic[@"text"];
      [_channel invokeMethod:@"result" arguments:result];
  });
}
 
@end

