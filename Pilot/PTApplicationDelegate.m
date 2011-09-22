//
//  PTApplicationDelegate.m
//  Pilot
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PTApplicationDelegate.h"

@implementation PTApplicationDelegate

@synthesize window = _window;

- (void)dealloc {
    [navigationController release];
    [_window release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window addSubview:self.navigationController.view];
    [self.window makeKeyAndVisible];
    
    return  YES;
}

#pragma - Accessors

- (UINavigationController *)navigationController {
    if (navigationController) return [[navigationController retain] autorelease];
    navigationController = [[UINavigationController alloc] initWithRootViewController:[self rootViewController]];
    return [[navigationController retain] autorelease];
}

- (UIViewController *)rootViewController {
    Class rootVCClass = NSClassFromString(@"RootViewController");
    UIViewController *rootVC = [[[rootVCClass alloc] init] autorelease];
    return rootVC;
}

@end
