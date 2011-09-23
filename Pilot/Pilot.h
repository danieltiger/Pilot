//
//  Pilot.h
//  Pilot
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PTApplicationDelegate.h"
#import "PTObject.h"


@interface Pilot : NSObject

/**
 *
 */
+ (void)showObject:(PTObject *)model withSelector:(SEL)selector animation:(UIViewAnimationTransition)transition;

/**
 * Returns a UIViewController for the class name
 */
+ (UIViewController *)viewControllerForClassName:(NSString *)name;

/**
 * Returns the name of the UIViewController sublcass to be used as the 
 * root view controller when building the UINavigationController
 */
+ (NSString *)rootViewControllerClassName;

+ (UIViewController *)rootViewController;

/**
 * Returns the [[UIApplication sharedApplication] delegate]
 */
+ (PTApplicationDelegate *)applicationDelegate;

/**
 * Returns the UINavigationController instance on the applicationDelegate
 * @see applicationDelegate
 */
+ (UINavigationController *)navigationController;

@end
