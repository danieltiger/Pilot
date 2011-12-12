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

+ (void)pushViewController:(id)viewController animated:(BOOL)animation {
    [[self currentNavigationController] pushViewController:viewController 
                                                  animated:animation];
}

+ (void)presentViewControllerAsModal:(id)viewController animated:(BOOL)animation {
    [[self currentNavigationController] presentModalViewController:viewController animated:animation];
}

+ (void)popTopViewControllerAnimated:(BOOL)animated {
    [[self currentNavigationController] popViewControllerAnimated:animated];
}

// TODO: Custom animations
//+ (void)pushViewController:(id)viewController 
//       withCustomAnimation:(UIViewAnimationTransition)animation 
//               andDuration:(CGFloat)duration {
//    
//    if (animation != UIViewAnimationOptionTransitionNone) {
//        [UIView transitionWithView:[self currentNavigationController].view 
//                          duration:duration
//                           options:animation
//                        animations:^{ 
//                            [[self currentNavigationController] pushViewController:viewController 
//                                                                          animated:NO];
//                        }
//                        completion:NULL];
//    } else {
//        [self pushViewController:viewController animated:NO];
//    }
//}

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

#pragma mark - Show

+ (void)showObject:(NSManagedObject *)object {
    [self showObject:object withSelector:[self defaultInitializer] animated:YES asModal:NO];
}

+ (void)showObject:(NSManagedObject *)object withSelector:(SEL)selector {
    [self showObject:object withSelector:selector animated:YES asModal:NO];
}

+ (void)showObject:(NSManagedObject *)object animated:(BOOL)animated {
    [self showObject:object withSelector:[self defaultInitializer] animated:animated asModal:NO];
}

+ (void)showObject:(NSManagedObject *)object withSelector:(SEL)selector animated:(BOOL)animated {
    [self showObject:object withSelector:selector animated:animated asModal:NO];
}

+ (void)showObjectAsModal:(NSManagedObject *)object {    
    [self showObject:object withSelector:[self defaultInitializer] animated:YES asModal:YES];
}

+ (void)showObjectAsModal:(NSManagedObject *)object withSelector:(SEL)selector {
    [self showObject:object withSelector:selector animated:YES asModal:YES];
}

+ (void)showObjectAsModal:(NSManagedObject *)object animated:(BOOL)animated {
    [self showObject:object withSelector:[self defaultInitializer] animated:animated asModal:YES];
}

+ (void)showObjectAsModal:(NSManagedObject *)object withSelector:(SEL)selector animated:(BOOL)animated {
    [self showObject:object withSelector:selector animated:animated asModal:YES];
}

+ (void)showObject:(NSManagedObject *)object withSelector:(SEL)selector animated:(BOOL)animated asModal:(BOOL)asModal {
    Class viewControllerClass = [self viewControllerClassForObject:object];
    
    NSAssert([viewControllerClass instancesRespondToSelector:selector], @"PILOT ERROR: Could not find selector %@ for %@ViewController", 
             NSStringFromSelector(selector), NSStringFromClass([object class]));
    
    NSAssert([object isKindOfClass:[NSManagedObject class]], @"PILOT ERROR: Object %@ is not a sublcass of NSManagedObject", 
             NSStringFromClass([object class]));
    
    id viewController = [[[viewControllerClass alloc] performSelector:selector withObject:object.objectID.URIRepresentation] autorelease];
    
    if (asModal) {
        [self presentViewControllerAsModal:viewController animated:animated];
    } else {
        [self pushViewController:viewController animated:animated];
    }
}

@end
