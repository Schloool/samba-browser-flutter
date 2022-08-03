#import "SambaBrowserPlugin.h"
#if __has_include(<samba_browser/samba_browser-Swift.h>)
#import <samba_browser/samba_browser-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "samba_browser-Swift.h"
#endif

@implementation SambaBrowserPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSambaBrowserPlugin registerWithRegistrar:registrar];
}
@end
