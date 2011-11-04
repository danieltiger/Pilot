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
    
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSString *modelPath = [testBundle pathForResource:@"PilotTestModel" 
                                               ofType:@"momd"];
        
    // Build Model
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL URLWithString:modelPath]];
    STAssertNotNil(model, @"Managed Object Model should exist");
    
    // Build persistent store coordinator
    coord = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // sqlite store path
    NSURL *storeURL = [[testBundle resourceURL] URLByAppendingPathComponent:@"PilotTests.sqlite"];
    
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
    
    // Setup Pilot
    rootViewController = [[UIViewController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    [Pilot setupWithNavigationController:navController];
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
    
    [rootViewController release], rootViewController = nil;
    [navController release], navController = nil;
    
    [Pilot reset];
    
    [super tearDown];
}

- (void)testShowPostObject {
    STFail(@"Kinda hard to test UI stuff here . . .");
}

@end
