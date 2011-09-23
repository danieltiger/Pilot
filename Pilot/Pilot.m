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
@end

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
    [[self navigationController] pushViewController:viewController animated:YES];
}

+ (void)presentViewControllerAsModal:(id)viewController withAnimation:(UIViewAnimationTransition)animation {
    [[self navigationController] presentModalViewController:viewController animated:YES];
}

#pragma mark - Public API

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
    
    NSAssert(object.identifier, @"PILOT ERROR: Could not find an instance variable named identifier on object %@", 
             NSStringFromClass([object class]));
    
    id viewController = [[[viewControllerClass alloc] performSelector:selector withObject:object.identifier] autorelease];
    
    if (asModal) {
        [self presentViewControllerAsModal:viewController withAnimation:animation];
    } else {
        [self presentViewController:viewController withAnimation:animation];
    }
}

#pragma mark - Accessors

+ (PTApplicationDelegate *)applicationDelegate {
    return (PTApplicationDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (UINavigationController *)navigationController {
    return self.applicationDelegate.navigationController;
}

@end
