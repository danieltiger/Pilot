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
@end

@implementation Pilot

#pragma mark - Private Methods

+ (Class)viewControllerClassForModel:(id)model {
    NSString *modelClassName = NSStringFromClass([model class]);
    NSString *viewControllerClassName = [NSString stringWithFormat:@"%@ViewController", modelClassName];
    
    return NSClassFromString(viewControllerClassName);
}

#pragma mark - Public API

+ (void)showObject:(PTObject *)model withSelector:(SEL)selector animation:(UIViewAnimationTransition)transition {
    Class viewControllerClass = [self viewControllerClassForModel:model];
    
    id viewController = [[viewControllerClass alloc] performSelector:selector withObject:model.identifier];
    [[self navigationController] pushViewController:viewController animated:YES];
}

#pragma mark - Accessors

+ (PTApplicationDelegate *)applicationDelegate {
    return (PTApplicationDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (UINavigationController *)navigationController {
    return self.applicationDelegate.navigationController;
}

@end
