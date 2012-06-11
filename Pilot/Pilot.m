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
static NSMutableArray *modalNavigationControllers = nil;

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
    [modalNavigationControllers removeAllObjects];
    modalNavigationControllers = nil;
}

+ (void)addModalNavigationController:(UINavigationController *)navController {

    if (!modalNavigationControllers) {
        modalNavigationControllers = [[NSMutableArray alloc] init];
    }
    
    [modalNavigationControllers addObject:navController];
}

#pragma mark - Navigation

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [[self currentNavigationController] pushViewController:viewController 
                                                  animated:animated];
}

+ (void)presentViewControllerAsModal:(UIViewController *)viewController animated:(BOOL)animated {
    [self presentViewControllerAsModal:viewController animated:animated withNewNavigationController:NO];
}

+ (void)presentViewControllerAsModal:(UIViewController *)viewController animated:(BOOL)animated withNewNavigationController:(BOOL)addNavigationController {
        
    if (addNavigationController) {
        
        UINavigationController *cachedController = [self currentNavigationController];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self addModalNavigationController:navController];
        
        [cachedController presentModalViewController:navController 
                                            animated:animated];
    } else {
        [[self currentNavigationController] presentModalViewController:viewController 
                                                              animated:animated];
    }
}

+ (void)popTopViewControllerAnimated:(BOOL)animated {

    if ([self topViewControllerIsModalNavigationControllerRoot]) {
        [modalNavigationControllers removeLastObject];
    }
    
    [[self currentNavigationController] popViewControllerAnimated:animated];
}

+ (void)popToModalRootViewControllerAnimated:(BOOL)animated {
    [[self currentNavigationController] popToRootViewControllerAnimated:animated];
}

+ (void)popToRootViewControllerAnimated:(BOOL)animated {
    [modalNavigationControllers removeAllObjects];
    [[self currentNavigationController] popToRootViewControllerAnimated:animated];
}

+ (void)pushViewController:(UIViewController *)viewController withAnimationBlock:(PilotAnimationBlock)animationBlock {
    
    if (!animationBlock) {
        [self pushViewController:viewController animated:YES];
        return;
    }

    [self pushViewController:viewController animated:NO];
    
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

+ (UINavigationController *)currentNavigationController {
    
    // Check for modal navigation controllers first
    if (modalNavigationControllers.count > 0) {
        return [modalNavigationControllers lastObject];
    }
    
    // Either setup with root navigation controller, or root tab bar controller
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

+ (BOOL)currentNavigationControllerIsModal {
    
    UINavigationController *modalNavigationController = [modalNavigationControllers lastObject];
    
    if (modalNavigationController) {
        if ([modalNavigationController isEqual:[self currentNavigationController]]) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)topViewControllerIsModalNavigationControllerRoot {
    UINavigationController *modalNavigationController = [modalNavigationControllers lastObject];

    if (modalNavigationController) {
        
        UIViewController *topViewController = [self topViewController];
        UIViewController *rootViewController = [modalNavigationController.viewControllers objectAtIndex:0];
        
        if ([topViewController isEqual:rootViewController]) {
            return YES;
        }
    }

    return NO;
}

+ (UIViewController *)topViewController {
    return [[self currentNavigationController] topViewController];
}

+ (UIViewController *)rootViewController {
    NSArray *viewControllers = [[self currentNavigationController] viewControllers];
    if (viewControllers.count == 0) return nil;
    return [viewControllers objectAtIndex:0];
}

#pragma mark - Building

+ (SEL)defaultInitializer {
    return NSSelectorFromString(@"initWithObjectURI:");
}

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

+ (void)showObject:(NSManagedObject *)object withAnimationBlock:(PilotAnimationBlock)animationBlock {
    [self showObject:object withAnimationBlock:animationBlock andSelector:[self defaultInitializer]];
}

+ (void)showObject:(NSManagedObject *)object withAnimationBlock:(PilotAnimationBlock)animationBlock andSelector:(SEL)selector { 
    
    UIViewController *viewController = [self viewControllerForOject:object withSelector:selector];
    
    [self pushViewController:viewController withAnimationBlock:animationBlock];;
}

@end
