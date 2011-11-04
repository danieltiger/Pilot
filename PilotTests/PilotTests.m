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
    
    // sqlite store path
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *storeURL = [[testBundle resourceURL] URLByAppendingPathComponent:@"PilotTests.sqlite"];
    
    // Build Model
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:storeURL];
    STAssertNotNil(model, @"Managed Object Model should exist");
    
    // Build persistent store coordinator
    coord = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // Build Store
    NSError *error = nil;
    store = [coord addPersistentStoreWithType:NSSQLiteStoreType
                                configuration:nil
                                          URL:storeURL
                                      options:nil 
                                        error:&error];
    
    // Build context
    context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:coord];
}

- (void)tearDown {
    
    [context release], context = nil;
    
    NSError *error = nil;
    STAssertTrue([coord removePersistentStore:store error:&error], 
                 @"couldn't remove persistent store: %@", error);
    
    store = nil;
    [coord release], coord = nil;
    [model release], model = nil;
    
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *storeURL = [[testBundle resourceURL] URLByAppendingPathComponent:@"PilotTests.sqlite"];
        
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (storeURL) {
        [fileManager removeItemAtURL:storeURL error:NULL];
    }
    
    [super tearDown];
}

- (void)testShowObject {

}

@end
