//
//  HJFlutterPlatformView.m
//  Runner
//
//  Created by Jayehuang on 2021/7/30.
//

#import "HJFlutterPlatformView.h"


@interface HJFlutterPlatformView ()

@end
@implementation HJFlutterPlatformView

- (nonnull UIView *)view {
    UIView *v = [[UIView alloc]init];
    v.frame = CGRectMake(0, 0, 80, 60);
    v.backgroundColor = [UIColor redColor];
    UILabel *title = [[UILabel alloc]init];
    title.text = @"原生view";
    title.font = [UIFont systemFontOfSize:14];
    title.textColor = [UIColor whiteColor];
    [v addSubview:title];
    title.frame = CGRectMake(0, 0, 80, 80);
    return v;
}

@end
