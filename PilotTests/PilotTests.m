//
//  PilotTests.m
//  PilotTests
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 Pilot. All rights reserved.
//

#import "PilotTests.h"
#import "Pilot.h"
#import "Post.h"
#import "PostViewController.h"


@implementation PilotTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testShowObject {
    Post *post = [[[Post alloc] init] autorelease];

    [Pilot showObject:post];
}

@end
