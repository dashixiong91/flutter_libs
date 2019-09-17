#import "AppFfiPlugin.h"
#import <app_ffi/app_ffi-Swift.h>

@implementation AppFfiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppFfiPlugin registerWithRegistrar:registrar];
}
@end
