//
//  PTTestObject.m
//  Pilot
//
//  Created by Andrew Smith on 9/23/11.
//  Copyright (c) 2011 Pilot. All rights reserved.
//

#import "PTTestObject.h"
#import "AppDelegate.h"

@implementation PTTestObject

@dynamic message;

#pragma mark - Factory

+ (id)objectWithUniqueMessage {
    
    NSString *objectEntityName = NSStringFromClass([self class]);
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];    
    
    PTTestObject *object = [NSEntityDescription insertNewObjectForEntityForName:objectEntityName 
                                              inManagedObjectContext:appDelegate.managedObjectContext];
    
    // Set message and save.  Saving in factory methods is not normally a good idea, performance wise,
    // but it will do for tests
    [object setMessage:[NSString stringWithFormat:@"Unique %@ Object: %@", NSStringFromClass(self), [object objectID]]];
    [object.managedObjectContext save:NULL];
    
    return object;
}

@end
