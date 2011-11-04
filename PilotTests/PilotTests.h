//
//  PilotTests.h
//  PilotTests
//
//  Created by Andrew Smith on 9/22/11.
//  Copyright 2011 Pilot. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface PilotTests : SenTestCase {
    NSPersistentStoreCoordinator *coord;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
    NSPersistentStore *store;

    UIViewController *rootViewController;
    UINavigationController *navController;
}

@end
