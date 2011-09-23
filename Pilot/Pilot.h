//
//  Pilot.h
//  Pilot
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 Pilot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "PTApplicationDelegate.h"
#import "PTObject.h"


@interface Pilot : NSObject

/**
 *
 */
+ (void)showObject:(PTObject *)object;

/**
 *
 */
+ (void)showObjectAsModal:(PTObject *)object;

/**
 *
 */
+ (void)showObject:(PTObject *)object withSelector:(SEL)selector;

/**
 *
 */
+ (void)showObjectAsModal:(PTObject *)object withSelector:(SEL)selector;

/**
 *
 */
+ (void)showObject:(PTObject *)object animation:(UIViewAnimationTransition)animation;

/**
 *
 */
+ (void)showObjectAsModal:(PTObject *)object animation:(UIViewAnimationTransition)animation;

/**
 *
 */
+ (void)showObject:(PTObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation;

/**
 *
 */
+ (void)showObjectAsModal:(PTObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation;

/**
 *
 */
+ (void)showObject:(PTObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation asModal:(BOOL)asModal;

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
