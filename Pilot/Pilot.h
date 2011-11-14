//
//  Pilot.h
//  Pilot
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 Pilot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>



@interface Pilot : NSObject

/**
 *
 */
+ (void)setupWithNavigationController:(UINavigationController *)navigationController;

/**
 *
 */
+ (void)setupWithTabBarController:(UITabBarController *)tabBarController;

/**
 * Reset Pilot to a clean state.
 */
+ (void)reset;

/**
 Pushes the objects view controller onto the stack
 */
+ (void)showObject:(NSManagedObject *)object;

/**
 *
 */
+ (void)showObjectAsModal:(NSManagedObject *)object;

/**
 *
 */
+ (void)showObject:(NSManagedObject *)object withSelector:(SEL)selector;

/**
 *
 */
+ (void)showObjectAsModal:(NSManagedObject *)object withSelector:(SEL)selector;

/**
 *
 */
+ (void)showObject:(NSManagedObject *)object animation:(UIViewAnimationTransition)animation;

/**
 Pushes the objects view controller onto the stack with the given animation transition
 over the given duration.
 */
+ (void)showObject:(NSManagedObject *)object animation:(UIViewAnimationTransition)animation duration:(CGFloat)duration;

/**
 *
 */
+ (void)showObjectAsModal:(NSManagedObject *)object animation:(UIViewAnimationTransition)animation;

/**
 *
 */
+ (void)showObject:(NSManagedObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation duration:(CGFloat)duration;

/**
 *
 */
+ (void)showObjectAsModal:(NSManagedObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation;

/**
 Pushes the objects view controller onto the stack with the given animation transition
 over the given duration, and performs the designated selector.
 */
+ (void)showObject:(NSManagedObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation duration:(CGFloat)duration asModal:(BOOL)asModal;

@end
