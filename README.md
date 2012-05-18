#Pilot

***

##Introduction
Pilot is designed to make managing the `UIViewController` stack of a `UINavigationController` backed app easy. 

##Setup
To setup Pilot with a single UINavigationController, use `setupWithNavigationController:` in your App delegates `didFinishLaunchingWithOptions:` method.

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
	UIViewController *rootViewController = [[UIViewController alloc] init];
	UINavigationController *navigationController = [[UINavigationController alloc] 	initWithRootViewController:rootViewController];
    
	[self.window addSubview:navigationController.view];
   	[self.window makeKeyAndVisible];
    
    [Pilot setupWithNavigationController:navigationController];
    
  	 return  YES;
}
```

Pilot also supports multiple `UINavigationControllers` through the use of a `UITabBarController`.  In your App delegates `didFinishLaunchingWithOptions:` method, do the following.

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{    
    	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    	UINavigationController *navController1 = 
    	[[UINavigationController alloc] initWithRootViewController:[[LeftViewController alloc] init]];    
    
    	UINavigationController *navController2 = 
    	[[UINavigationController alloc] initWithRootViewController:[[RightViewController alloc] init]];
    
    	UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2, nil];
    
    	// SETUP PILOT
    	[Pilot setupWithTabBarController:tabBarController];
    
    	self.window.rootViewController = tabBarController;
    	[self.window makeKeyAndVisible];
    	return YES;
	}

##Pushing

To push a new view controller onto the stack.
    
    UIViewController *viewController = [[UIViewController alloc] init];
    [Pilot pushViewController:viewController animated:YES];

##Popping

To pop the top view controller off the stack.

    [Pilot popTopViewControllerAnimated:YES];
    
To pop to the root view controller

    [Pilot popToRootViewControllerAnimated:YES];

##Modals

To show a UIViewController as modal with support for `UIModalTransitionStyle`.
     
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [Pilot presentViewControllerAsModal:viewController animated:YES];

##Custom Animations

Pilot now has support for custom animation transitions when pushing a view controller through block animations.  In this example the view controllers view will fade in over 0.3 seconds.
   
    PilotAnimationBlock animationblock = ^(UIViewController *viewController) {
        viewController.view.alpha = 0.0;
        [UIView animateWithDuration:1.0 animations:^ {
            viewController.view.alpha = 1.0;
        }];
    };
    
   	[Pilot pushViewController:viewController withAnimationBlock:animationBlock];
 
##Core Data
 
Pilot has some super useful conventions for working with CoreData objects.  By using these conventions, building a view controller from an `NSManagedObject` subclass is really easy.  This section of the documentation is in progress.

##Contributing

Forks, patches and other feedback are always welcome. 

### Pilot is brought to you by [Posterous](http://posterous.com)###

Contributors:

* [Arik Devens](http://github.com/danieltiger)
* [Andrew B. Smith](http://github.com/drewsmits).
