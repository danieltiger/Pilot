//
//  PTApplicationDelegate.h
//  Pilot
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTApplicationDelegate : NSObject <UIApplicationDelegate> {
@private
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, readonly) UINavigationController *navigationController;

/**
 * Return the the RootViewController used to build the navigationController.
 * Default is to look for a UIViewController named RootViewController.
 */
- (UIViewController *)rootViewController;

@end
