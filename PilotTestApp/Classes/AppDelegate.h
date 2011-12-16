//
//  AppDelegate.h
//  PilotTestApp
//
//  Created by Andrew Smith on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UINavigationController *navigationController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;

/**
 * The UINavigationControllers RootViewController
 */
@property (unsafe_unretained, nonatomic, readonly) UIViewController *rootViewController;

/**
 * The apps navigation controller.
 */
@property (unsafe_unretained, nonatomic, readonly) UINavigationController *navigationController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
