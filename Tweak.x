@import Foundation;
#include <SpringBoard/SBApplication.h>
#include <SpringBoard/SBApplicationController.h>

@interface ConfusionAndDelay : NSObject
- (void)startTrainwreck;
@end

@implementation ConfusionAndDelay
- (void)startTrainwreck {
  [NSTimer scheduledTimerWithTimeInterval:0.5f
                                   target:self
                                 selector:@selector(dispatchTrainwreck:)
                                 userInfo:nil
                                  repeats:YES];
}

- (void)dispatchTrainwreck:(NSTimer *)timer {
  // Could this be cleaner? Absolutely!
  // Will this be cleaner? Absolutely not.
  [self randomizeForBundleID:@"com.apple.mobilemail"];
  [self randomizeForBundleID:@"ru.yandex.mail"];
  [self randomizeForBundleID:@"com.readdle.smartemail"];
  [self randomizeForBundleID:@"io.polymail.ios"];
  [self randomizeForBundleID:@"com.aol.mobile.aolclient"];
  [self randomizeForBundleID:@"com.yahoo.Aerogram"];
  [self randomizeForBundleID:@"ch.protonmail.protonmail"];
  [self randomizeForBundleID:@"com.microsoft.Office.Outlook"];
  [self randomizeForBundleID:@"com.google.Gmail"];
}

- (void)randomizeForBundleID:(NSString *)bundleID {
  SBApplication *app = [[%c(SBApplicationController) sharedInstance]
      applicationWithBundleIdentifier:bundleID];
  int badge = arc4random_uniform(99999);
  [app setBadgeValue:[NSNumber numberWithInt:badge]];
}
@end

%hook SpringBoard
- (void)applicationDidFinishLaunching : (id)application {
  %orig;

  ConfusionAndDelay *cthulhu = [[ConfusionAndDelay alloc] init];
  [cthulhu startTrainwreck];
}
%end

%hook SBIconController
// I would rather not have to sign into these mail clients,
// so we'll force showing badges.
- (BOOL)iconAllowsBadging:(id)icon {
  return YES;
}
%end
