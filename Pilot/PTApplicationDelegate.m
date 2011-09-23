//
//  PTApplicationDelegate.m
//  Pilot
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PTApplicationDelegate.h"
#import "Pilot.h"

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
    navigationController = [[UINavigationController alloc] initWithRootViewController:[Pilot rootViewController]];
    return [[navigationController retain] autorelease];
}

@end
