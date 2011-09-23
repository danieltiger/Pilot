//
//  PTObject.m
//  Pilot
//
//  Created by Arik Devens on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PTObject.h"


@implementation PTObject

@synthesize identifier;

- (void)dealloc {
    [identifier release];
    self.identifier = nil;
    
    [super dealloc];
}

@end
