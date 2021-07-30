//
//  HJFlutterPlatformFactory.m
//  Runner
//
//  Created by Jayehuang on 2021/7/30.
//

#import "HJFlutterPlatformFactory.h"
#import "HJFlutterPlatformView.h"

@interface HJFlutterPlatformFactory ()

@end
@implementation HJFlutterPlatformFactory

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    /// viewId ,args 可传递使用
    return [[HJFlutterPlatformView alloc]init];
}

@end
