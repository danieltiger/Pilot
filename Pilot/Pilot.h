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

typedef void (^PilotAnimationBlock)(UIViewController *navigationController);

@interface Pilot : NSObject

/**
 Setup Pilot to use the input navigation controller for all navigation.  Usually
 You would build the navigation controller in your AppDelegat.  See the PilotTestApp
 for more details.
 
 @params navigationController This will be used as the app-wide navigation controller
 */
+ (void)setupWithNavigationController:(UINavigationController *)navigationController;

+ (void)setupWithTabBarController:(UITabBarController *)tabBarController;

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

+ (void)pushViewController:(UIViewController *)viewController withCustomAnimationBlock:(PilotAnimationBlock)animationBlock;

+ (void)presentViewControllerAsModal:(UIViewController *)viewController animated:(BOOL)animated;

/**
 Pops the top view controller off the stack
 */
+ (void)popTopViewControllerAnimated:(BOOL)animated;

+ (void)popToRootViewControllerAnimated:(BOOL)animated;


/**
 Returns the view controller class for the given NSManagedObject.  This follows
 a naming convention of "<Object Class Name>ViewController".
 */
+ (Class)viewControllerClassForObject:(NSManagedObject *)object;

/**
 The default initializer on the View Controller to be presented
 */
+ (SEL)defaultInitializer;

/**
 Returns the current navigation controller.  If using a Tabbar app, this will
 return the current selected view controller
 */
+ (UINavigationController *)currentNavigationController;

/**
 * Reset Pilot to a clean state.
 */
+ (void)reset;

/**
 Builds a UIViewController using Pilot naming conventions for the given object, 
 and uses the initialization selector.
 */

+ (UIViewController *)viewControllerForOject:(NSManagedObject *)object withSelector:(SEL)selector;

/**
 Pushes the objects view controller onto the stack
 */
+ (void)showObject:(NSManagedObject *)object;

+ (void)showObject:(NSManagedObject *)object animated:(BOOL)animated;

+ (void)showObject:(NSManagedObject *)object withInitializationSelector:(SEL)selector;

+ (void)showObject:(NSManagedObject *)object withInitializationSelector:(SEL)selector animated:(BOOL)animated;

/**
 Pushes the objects view controller onto the stack with custom animations
 */
+ (void)showObject:(NSManagedObject *)object withCustomAnimationBlock:(PilotAnimationBlock)animationBlock;

+ (void)showObject:(NSManagedObject *)object withCustomAnimationBlock:(PilotAnimationBlock)animationBlock andSelector:(SEL)selector;

/**
 Pushes the objects view controller onto the stack as a modal ViewController
 */
+ (void)showObjectAsModal:(NSManagedObject *)object;

+ (void)showObjectAsModal:(NSManagedObject *)object animated:(BOOL)animated;

+ (void)showObjectAsModal:(NSManagedObject *)object withInitializationSelector:(SEL)selector;

+ (void)showObjectAsModal:(NSManagedObject *)object withInitializationSelector:(SEL)selector animated:(BOOL)animated;

/**
 All "show" actions filter down to this method
 */
+ (void)showObject:(NSManagedObject *)object withInitializationSelector:(SEL)selector animated:(BOOL)animated asModal:(BOOL)asModal;

@end
