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


@interface Pilot : NSObject

+ (Class)viewControllerClassForModel:(id)model;

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
