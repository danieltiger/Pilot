//
//  Pilot.m
//  Pilot
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Pilot.h"

@implementation Pilot

- (id)init {
    if (self = [super init]) {
        // Initialization code here.
    }
    
    return self;
}

+ (Class)viewControllerClassForModel:(id)model {
    NSString *modelClassName = NSStringFromClass([model class]);
    NSString *viewControllerClassName = [NSString stringWithFormat:@"%@ViewController", modelClassName];
    
    return NSClassFromString(viewControllerClassName);
}

+ (void)showModel:(id)model withSelector:(SEL)selector animation:(UIViewAnimationTransition)transition {
    Class viewControllerClass = [self viewControllerClassForModel:model];
    
    id viewController = [[viewControllerClass alloc] performSelector:selector];
    [[self navigationController] pushViewController:viewController animated:YES];
}

+ (UIViewController *)viewControllerForClassName:(NSString *)name {
    Class vcClass = NSClassFromString(name);
    
    NSAssert(vcClass, @"PILOT ERROR:  Could not find ViewController class named %@", name);
    
    UIViewController *vc = [[[vcClass alloc] init] autorelease];
    return vc;
}

#pragma - Accessors

+ (UIViewController *)rootViewController {
    return [self viewControllerForClassName:[self rootViewControllerClassName]];
}

+ (NSString *)rootViewControllerClassName {
    return @"RootViewController";
}

+ (PTApplicationDelegate *)applicationDelegate {
    return (PTApplicationDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (UINavigationController *)navigationController {
    return self.applicationDelegate.navigationController;
}

@end
