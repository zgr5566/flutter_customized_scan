
#ifndef CustomizedScanView_h
#define CustomizedScanView_h
#import <Flutter/Flutter.h>
#import <ScanKitFrameWork/ScanKitFrameWork.h>

@interface CustomizedScanView : NSObject<FlutterPlatformView>
@property (nonatomic,strong) HmsCustomScanViewController *hmsCustomScanViewController;
- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end

#endif /* CustomizedScanView_h */
