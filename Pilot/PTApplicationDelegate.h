//
//  PTApplicationDelegate.h
//  Pilot
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 Pilot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTApplicationDelegate : UIResponder <UIApplicationDelegate> {
@private
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

/**
 * The UINavigationControllers RootViewController
 */
@property (nonatomic, readonly) UIViewController *rootViewController;

/**
 * The apps navigation controller.
 */
@property (nonatomic, readonly) UINavigationController *navigationController;

/**
 * Returns the shared application delegate
 */
+ (PTApplicationDelegate *)sharedDelegate;

@end
