//
//  Pilot.m
//  Pilot
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 Pilot. All rights reserved.
//

#import "Pilot.h"


@interface Pilot (hidden)
+ (Class)viewControllerClassForModel:(id)model;
+ (void)presentViewController:(id)viewController;
+ (void)presentViewControllerAsModal:(id)viewController;
@end

@implementation Pilot

#pragma mark - Private Methods

+ (Class)viewControllerClassForModel:(id)model {
    NSString *modelClassName = NSStringFromClass([model class]);
    NSString *viewControllerClassName = [NSString stringWithFormat:@"%@ViewController", modelClassName];
    
    NSAssert(NSClassFromString(viewControllerClassName), @"PILOT ERROR: Could not find %@ViewController", modelClassName);
    
    return NSClassFromString(viewControllerClassName);
}

+ (void)presentViewController:(id)viewController {
    [[self navigationController] pushViewController:viewController animated:YES];
}

+ (void)presentViewControllerAsModal:(id)viewController {
    [[self navigationController] presentModalViewController:viewController animated:YES];
}

#pragma mark - Public API

+ (void)showObject:(PTObject *)model withSelector:(SEL)selector animation:(UIViewAnimationTransition)transition asModal:(BOOL)asModal {
    Class viewControllerClass = [self viewControllerClassForModel:model];

    NSAssert([viewControllerClass instancesRespondToSelector:selector], @"PILOT ERROR: Could not find selector: %@ for %@ViewController", 
             NSStringFromSelector(selector), NSStringFromClass([model class])]);
    
    id viewController = [[[viewControllerClass alloc] performSelector:selector withObject:model.identifier] autorelease];
    
    if (asModal) {
        [self presentViewControllerAsModal:viewController];
    } else {
        [self presentViewController:viewController];
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
