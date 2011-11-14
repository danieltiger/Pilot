//
//  Pilot.m
//  Pilot
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 Pilot. All rights reserved.
//

#import "Pilot.h"

#define PILOT_ANIMATION_DURATION 0.3

@interface Pilot (Private)
+ (Class)viewControllerClassForObject:(NSManagedObject *)object;
+ (SEL)defaultInitializer;
+ (void)presentViewController:(id)viewController withAnimation:(UIViewAnimationTransition)animation;
+ (void)presentViewControllerAsModal:(id)viewController withAnimation:(UIViewAnimationTransition)animation;
+ (UINavigationController *)currentNavigationController;
@end

static UINavigationController *rootNavigationController = nil;
static UITabBarController *rootTabBarController = nil;

@implementation Pilot

#pragma mark - Private Methods

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

+ (void)presentViewController:(id)viewController withAnimation:(UIViewAnimationTransition)animation andDuration:(CGFloat)duration {
    
    if (animation != UIViewAnimationOptionTransitionNone) {
        [UIView transitionWithView:[self currentNavigationController].view 
                          duration:duration
                           options:animation
                        animations:^{ 
                            [[self currentNavigationController] pushViewController:viewController 
                                                                          animated:NO];
                        }
                        completion:NULL];
    } else {
        [[self currentNavigationController] pushViewController:viewController animated:YES];        
    }
}

+ (void)presentViewControllerAsModal:(id)viewController withAnimation:(UIViewAnimationTransition)animation {
    [[self currentNavigationController] presentModalViewController:viewController animated:YES];
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

#pragma mark - Public API

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

+ (void)showObject:(NSManagedObject *)object {
    [self showObject:object withSelector:[self defaultInitializer] animation:UIViewAnimationTransitionNone duration:PILOT_ANIMATION_DURATION asModal:NO];
}

+ (void)showObjectAsModal:(NSManagedObject *)object {
    [self showObject:object withSelector:[self defaultInitializer] animation:UIViewAnimationTransitionNone duration:PILOT_ANIMATION_DURATION asModal:YES];
}

+ (void)showObject:(NSManagedObject *)object withSelector:(SEL)selector {
    [self showObject:object withSelector:selector animation:UIViewAnimationTransitionNone duration:PILOT_ANIMATION_DURATION asModal:NO];
}

+ (void)showObjectAsModal:(NSManagedObject *)object withSelector:(SEL)selector {
    [self showObject:object withSelector:selector animation:UIViewAnimationTransitionNone duration:PILOT_ANIMATION_DURATION asModal:YES];
}

+ (void)showObject:(NSManagedObject *)object animation:(UIViewAnimationTransition)animation {
    [self showObject:object withSelector:[self defaultInitializer] animation:animation duration:PILOT_ANIMATION_DURATION asModal:NO];
}

+ (void)showObject:(NSManagedObject *)object animation:(UIViewAnimationTransition)animation duration:(CGFloat)duration {
    [self showObject:object withSelector:[self defaultInitializer] animation:animation duration:duration asModal:NO];
}

+ (void)showObjectAsModal:(NSManagedObject *)object animation:(UIViewAnimationTransition)animation {
    [self showObject:object withSelector:[self defaultInitializer] animation:animation duration:PILOT_ANIMATION_DURATION asModal:YES];
}

+ (void)showObject:(NSManagedObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation duration:(CGFloat)duration {
    [self showObject:object withSelector:selector animation:animation duration:duration asModal:NO];
}

+ (void)showObjectAsModal:(NSManagedObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation {
    [self showObject:object withSelector:selector animation:animation duration:PILOT_ANIMATION_DURATION asModal:YES];
}

+ (void)showObject:(NSManagedObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation duration:(CGFloat)duration asModal:(BOOL)asModal {
    Class viewControllerClass = [self viewControllerClassForObject:object];
    
    NSAssert([viewControllerClass instancesRespondToSelector:selector], @"PILOT ERROR: Could not find selector %@ for %@ViewController", 
             NSStringFromSelector(selector), NSStringFromClass([object class]));
    
    NSAssert([object isKindOfClass:[NSManagedObject class]], @"PILOT ERROR: Object %@ is not a sublcass of NSManagedObject", 
             NSStringFromClass([object class]));
    
    id viewController = [[[viewControllerClass alloc] performSelector:selector withObject:object.objectID.URIRepresentation] autorelease];
    
    if (asModal) {
        [self presentViewControllerAsModal:viewController withAnimation:animation];
    } else {
        [self presentViewController:viewController withAnimation:animation andDuration:duration];
    }
}

@end
