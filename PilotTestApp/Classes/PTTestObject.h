//
//  PTTestObject.h
//  Pilot
//
//  Created by Andrew Smith on 9/23/11.
//  Copyright (c) 2011 Pilot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Pilot/PTObject.h"

@interface PTTestObject : PTObject

@property (nonatomic, retain) NSString * message;

+ (id)objectWithMessage:(NSString *)message;

@end
