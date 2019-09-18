#import "AppFfiPlugin.h"

// 考虑到此插件仅仅支持作为ffi的模板项目，并不实际需要插件的能力，所以删除了默认的代码
@implementation AppFfiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  
}
@end
