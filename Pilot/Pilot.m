//
//  Pilot.m
//  Pilot
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 Pilot. All rights reserved.
//

#import "Pilot.h"


@interface Pilot (hidden)
+ (Class)viewControllerClassForObject:(PTObject *)object;
+ (SEL)defaultInitializer;
+ (void)presentViewController:(id)viewController withAnimation:(UIViewAnimationTransition)animation;
+ (void)presentViewControllerAsModal:(id)viewController withAnimation:(UIViewAnimationTransition)animation;
+ (UINavigationController *)currentNavigationController;
@end

static UINavigationController *rootNavigationController = nil;
static UITabBarController *rootTabBarController = nil;

@implementation Pilot

#pragma mark - Private Methods

+ (Class)viewControllerClassForObject:(PTObject *)object {
    NSString *objectClassName = NSStringFromClass([object class]);
    NSString *viewControllerClassName = [NSString stringWithFormat:@"%@ViewController", objectClassName];

    NSAssert(NSClassFromString(viewControllerClassName), @"PILOT ERROR: Could not find %@", viewControllerClassName);
        
    return NSClassFromString(viewControllerClassName);
}

+ (SEL)defaultInitializer {
    return NSSelectorFromString(@"initWithObjectIdentifier:");
}

+ (void)presentViewController:(id)viewController withAnimation:(UIViewAnimationTransition)animation {
    [[self currentNavigationController] pushViewController:viewController animated:YES];
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

+ (void)initWithNavigationController:(UINavigationController *)navigationController {
    rootNavigationController = navigationController;
}

+ (void)initWithTabBarController:(UITabBarController *)tabBarController {
    rootTabBarController = tabBarController;
}

+ (void)showObject:(PTObject *)object {
    [self showObject:object withSelector:[self defaultInitializer] animation:UIViewAnimationTransitionNone asModal:NO];
}

+ (void)showObjectAsModal:(PTObject *)object {
    [self showObject:object withSelector:[self defaultInitializer] animation:UIViewAnimationTransitionNone asModal:YES];
}

+ (void)showObject:(PTObject *)object withSelector:(SEL)selector {
    [self showObject:object withSelector:selector animation:UIViewAnimationTransitionNone asModal:NO];
}

+ (void)showObjectAsModal:(PTObject *)object withSelector:(SEL)selector {
    [self showObject:object withSelector:selector animation:UIViewAnimationTransitionNone asModal:YES];
}

+ (void)showObject:(PTObject *)object animation:(UIViewAnimationTransition)animation {
    [self showObject:object withSelector:[self defaultInitializer] animation:animation asModal:NO];
}

+ (void)showObjectAsModal:(PTObject *)object animation:(UIViewAnimationTransition)animation {
    [self showObject:object withSelector:[self defaultInitializer] animation:animation asModal:YES];
}

+ (void)showObject:(PTObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation {
    [self showObject:object withSelector:selector animation:animation asModal:NO];
}

+ (void)showObjectAsModal:(PTObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation {
    [self showObject:object withSelector:selector animation:animation asModal:YES];
}

+ (void)showObject:(PTObject *)object withSelector:(SEL)selector animation:(UIViewAnimationTransition)animation asModal:(BOOL)asModal {
    Class viewControllerClass = [self viewControllerClassForObject:object];
    
    NSAssert([viewControllerClass instancesRespondToSelector:selector], @"PILOT ERROR: Could not find selector %@ for %@ViewController", 
             NSStringFromSelector(selector), NSStringFromClass([object class]));
    
    NSAssert([object respondsToSelector:@selector(identifier)], @"PILOT ERROR: Could not find an instance variable named identifier on object %@", 
             NSStringFromClass([object class]));
    
    id viewController = [[[viewControllerClass alloc] performSelector:selector withObject:[object identifier]] autorelease];
    
    if (asModal) {
        [self presentViewControllerAsModal:viewController withAnimation:animation];
    } else {
        [self presentViewController:viewController withAnimation:animation];
    }
}

@end
