//
//  Pilot.m
//  Pilot
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 Pilot. All rights reserved.
//

#import "Pilot.h"

static UINavigationController *rootNavigationController = nil;
static UITabBarController *rootTabBarController = nil;

@implementation Pilot

#pragma mark - Setup

+ (void)setupWithNavigationController:(UINavigationController *)navigationController {
    rootNavigationController = navigationController;
}

+ (void)setupWithTabBarController:(UITabBarController *)tabBarController {
    rootTabBarController = tabBarController;
}

+ (void)reset {
    rootNavigationController = nil;
    rootTabBarController = nil;
}

#pragma mark - Navigation

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [[self currentNavigationController] pushViewController:viewController 
                                                  animated:animated];
}

+ (void)presentViewControllerAsModal:(UIViewController *)viewController animated:(BOOL)animated {
    [[self currentNavigationController] presentModalViewController:viewController 
                                                          animated:animated];
}

+ (void)popTopViewControllerAnimated:(BOOL)animated {
    [[self currentNavigationController] popViewControllerAnimated:animated];
}

+ (void)popToRootViewControllerAnimated:(BOOL)animated {
    [[self currentNavigationController] popToRootViewControllerAnimated:animated];
}

+ (void)pushViewController:(UIViewController *)viewController 
  withCustomAnimationBlock:(PilotAnimationBlock)animationBlock {
    
    if (!animationBlock) {
        [self pushViewController:viewController animated:NO];
    }

    [[self currentNavigationController] pushViewController:viewController 
                                                  animated:NO];
    
    animationBlock(viewController);
}

#pragma mark - 

+ (Class)viewControllerClassForObject:(NSManagedObject *)object {
    
    NSAssert(object, @"PILOT ERROR: nil object passed in!", object);
    if (!object) return nil;
    
    NSString *objectClassName = NSStringFromClass([object class]);
    NSString *viewControllerClassName = [NSString stringWithFormat:@"%@ViewController", objectClassName];

    NSAssert(NSClassFromString(viewControllerClassName), @"PILOT ERROR: Could not find %@", viewControllerClassName);
    if (!viewControllerClassName) return nil;
        
    return NSClassFromString(viewControllerClassName);
}

+ (SEL)defaultInitializer {
    return NSSelectorFromString(@"initWithObjectURI:");
}

+ (UINavigationController *)currentNavigationController {
    if (rootNavigationController) {
        return rootNavigationController;
    } else {
        UIViewController *navigationController = rootTabBarController.selectedViewController;

        if ([navigationController isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)navigationController;
        }
    }
    
    return nil;
}

#pragma mark - 

+ (UIViewController *)viewControllerForOject:(NSManagedObject *)object withSelector:(SEL)selector {
    Class viewControllerClass = [self viewControllerClassForObject:object];
    
    NSAssert([viewControllerClass instancesRespondToSelector:selector], @"PILOT ERROR: Could not find selector %@ for %@ViewController", 
             NSStringFromSelector(selector), NSStringFromClass([object class]));
    
    NSAssert([object isKindOfClass:[NSManagedObject class]], @"PILOT ERROR: Object %@ is not a sublcass of NSManagedObject", 
             NSStringFromClass([object class]));
    
    UIViewController *viewController = (UIViewController *)[[viewControllerClass alloc] performSelector:selector withObject:object.objectID.URIRepresentation];

    return viewController;
}

#pragma mark - Show

+ (void)showObject:(NSManagedObject *)object {
    [self showObject:object withInitializationSelector:[self defaultInitializer] animated:YES asModal:NO];
}

+ (void)showObject:(NSManagedObject *)object withInitializationSelector:(SEL)selector {
    [self showObject:object withInitializationSelector:selector animated:YES asModal:NO];
}

+ (void)showObject:(NSManagedObject *)object animated:(BOOL)animated {
    [self showObject:object withInitializationSelector:[self defaultInitializer] animated:animated asModal:NO];
}

+ (void)showObject:(NSManagedObject *)object withInitializationSelector:(SEL)selector animated:(BOOL)animated {
    [self showObject:object withInitializationSelector:selector animated:animated asModal:NO];
}

+ (void)showObjectAsModal:(NSManagedObject *)object {    
    [self showObject:object withInitializationSelector:[self defaultInitializer] animated:YES asModal:YES];
}

+ (void)showObjectAsModal:(NSManagedObject *)object withInitializationSelector:(SEL)selector {
    [self showObject:object withInitializationSelector:selector animated:YES asModal:YES];
}

+ (void)showObjectAsModal:(NSManagedObject *)object animated:(BOOL)animated {
    [self showObject:object withInitializationSelector:[self defaultInitializer] animated:animated asModal:YES];
}

+ (void)showObjectAsModal:(NSManagedObject *)object withInitializationSelector:(SEL)selector animated:(BOOL)animated {
    [self showObject:object withInitializationSelector:selector animated:animated asModal:YES];
}

+ (void)showObject:(NSManagedObject *)object withInitializationSelector:(SEL)selector animated:(BOOL)animated asModal:(BOOL)asModal {
    
    UIViewController *viewController = [self viewControllerForOject:object withSelector:selector];
    
    if (asModal) {
        [self presentViewControllerAsModal:viewController animated:animated];
    } else {
        [self pushViewController:viewController animated:animated];
    }
}

#pragma mark - Show Custom Animations

+ (void)showObject:(NSManagedObject *)object withCustomAnimationBlock:(PilotAnimationBlock)animationBlock {
    [self showObject:object withCustomAnimationBlock:animationBlock andSelector:[self defaultInitializer]];
}

+ (void)showObject:(NSManagedObject *)object withCustomAnimationBlock:(PilotAnimationBlock)animationBlock andSelector:(SEL)selector { 
    
    UIViewController *viewController = [self viewControllerForOject:object withSelector:selector];
    
    [self pushViewController:viewController 
    withCustomAnimationBlock:animationBlock];
}

@end
