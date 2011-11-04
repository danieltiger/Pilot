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
 *
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
 *
 */
+ (void)showObjectAsModal:(NSManagedObject *)object animation:(UIViewAnimationTransition)animation;

/**
 *
 */
+ (void)showObject:(NSManagedObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation;

/**
 *
 */
+ (void)showObjectAsModal:(NSManagedObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation;

/**
 *
 */
+ (void)showObject:(NSManagedObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation asModal:(BOOL)asModal;

@end
