//
//  PilotTests.m
//  PilotTests
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PilotTests.h"
#import "Pilot.h"


@interface Post : NSObject {
}
@end

@interface PostViewController : NSObject {
}
@end

@implementation Post
@end

@implementation PostViewController
@end

@implementation PilotTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testViewControllerClassForModel {
    Post *post = [[Post alloc] init];
    PostViewController *postViewController = [[PostViewController alloc] init];
    
    STAssertEquals([Pilot viewControllerClassForModel:post], [PostViewController class], @"Test that the returned class is the same as the expected class");
    
    [post release];
    [postViewController release];
}

- (void)testViewControllerForNameThatExists {
    STAssertNotNil([Pilot viewControllerForClassName:@"PostViewController"], @"Pilot should find view controller that exists");
}

- (void)testViewControllerForNameThatDoesntExist {
    STAssertThrows([Pilot viewControllerForClassName:@"FooViewController"], @"Pilot should not find view controller that doesn't exist");
}

@end
