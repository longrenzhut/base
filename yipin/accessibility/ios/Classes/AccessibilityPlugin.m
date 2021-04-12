#import "AccessibilityPlugin.h"
#if __has_include(<accessibility/accessibility-Swift.h>)
#import <accessibility/accessibility-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "accessibility-Swift.h"
#endif

@implementation AccessibilityPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAccessibilityPlugin registerWithRegistrar:registrar];
}
@end
