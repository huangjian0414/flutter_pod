#import "AppDelegate.h"
#import "FlutterPluginRegistrant/GeneratedPluginRegistrant.h"

#import "HJFlutterPlatformFactory.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    
    [[self registrarForPlugin:@"HJNativeView"]registerViewFactory:[[HJFlutterPlatformFactory alloc]init] withId:@"HJNativeView"];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
