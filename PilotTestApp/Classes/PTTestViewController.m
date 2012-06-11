//
//  PTTestViewController.m
//  Pilot
//
//  Created by Andrew Smith on 9/23/11.
//  Copyright (c) 2011 Pilot. All rights reserved.
//

#import "PTTestViewController.h"
#import "Pilot.h"

#import "RedObject.h"
#import "GreenObject.h"
#import "BlueObject.h"

@implementation PTTestViewController

@synthesize objectMessage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithObjectURI:(NSURL *)objectURL {
    
    if (self = [self initWithNibName:nil bundle:nil]) {
        self.objectMessage = [NSString stringWithFormat:@"%@",objectURL];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Title
//    UILabel *titleLabel = [[[UILabel alloc] init] autorelease];
//    NSInteger index = [[[Pilot navigationController] viewControllers] count];    
//    titleLabel.text = [NSString stringWithFormat:@"%@ #%d", NSStringFromClass([self class]), index];
//    [titleLabel sizeToFit];
//    [self.view addSubview:titleLabel];
        
    // Message
    UILabel *objectMessageLabel = [[UILabel alloc] init];
    objectMessageLabel.numberOfLines = 0;
    objectMessageLabel.text = self.objectMessage;
    
    CGSize size = [self.objectMessage sizeWithFont:[objectMessageLabel font] 
                            constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:UILineBreakModeTailTruncation];
    objectMessageLabel.frame = CGRectMake(0, 0, size.width, size.height);  
    [self.view addSubview:objectMessageLabel];
    
    // Red
    UIButton *redButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [redButton setTitle:@"Show Red w/o Animation" forState:UIControlStateNormal];
    [redButton addTarget:self action:@selector(redButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [redButton sizeToFit];
    [self.view addSubview:redButton];
    
    UIButton *redButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [redButton2 setTitle:@"Show Red w/ custom Animation" forState:UIControlStateNormal];
    [redButton2 addTarget:self action:@selector(redButtonCustomAnimationAction) forControlEvents:UIControlEventTouchUpInside];
    [redButton2 sizeToFit];
    [self.view addSubview:redButton2];
    
    // Green
    UIButton *greenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [greenButton setTitle:@"Show Green" forState:UIControlStateNormal];
    [greenButton addTarget:self action:@selector(greenButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [greenButton sizeToFit];
    [self.view addSubview:greenButton];
    
    // Blue
    UIButton *blueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [blueButton setTitle:@"Show Blue" forState:UIControlStateNormal];
    [blueButton addTarget:self action:@selector(blueButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [blueButton sizeToFit];
    [self.view addSubview:blueButton];
    
    // Pop
    UIButton *popButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [popButton setTitle:@"Pop" forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(popButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [popButton sizeToFit];
    [self.view addSubview:popButton];
    
    // Pop Animated
    UIButton *popAnimatedButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [popAnimatedButton setTitle:@"Pop Animated" forState:UIControlStateNormal];
    [popAnimatedButton addTarget:self action:@selector(popAnimatedButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [popAnimatedButton sizeToFit];
    [self.view addSubview:popAnimatedButton];
    
    UIButton *popCustomAnimatedButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [popCustomAnimatedButton setTitle:@"Pop w/ custom Animation" forState:UIControlStateNormal];
    [popCustomAnimatedButton addTarget:self action:@selector(popCustomAnimatedButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [popCustomAnimatedButton sizeToFit];
    [self.view addSubview:popCustomAnimatedButton];
    
    // This is just a convience function to layout the title and buttons
    [self layoutViews];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma - Target-Action

- (void)redButtonAction {
    RedObject *newRedObject = [RedObject objectWithUniqueMessage];
    [Pilot showObject:newRedObject animated:NO];
}

- (void)redButtonCustomAnimationAction {
    RedObject *newRedObject = [RedObject objectWithUniqueMessage];
    
    PilotAnimationBlock animationblock = ^(UIViewController *viewController) {
        viewController.view.alpha = 0.0;

        [UIView animateWithDuration:1.0 animations:^ {
            viewController.view.alpha = 1.0;
        }];
    };

    [Pilot showObject:newRedObject withAnimationBlock:animationblock];

}

- (void)greenButtonAction {
    GreenObject *newGreenObject = [GreenObject objectWithUniqueMessage];
    [Pilot showObject:newGreenObject];
}

- (void)blueButtonAction {
    BlueObject *newBlueObject = [BlueObject objectWithUniqueMessage];
    [Pilot showObject:newBlueObject];
}

- (void)popButtonAction {
    [Pilot popTopViewControllerAnimated:NO];
}

- (void)popAnimatedButtonAction {
    [Pilot popTopViewControllerAnimated:YES];
}

- (void)popCustomAnimatedButtonAction {

    UIViewController *viewController = [Pilot topViewController];
    
    [UIView animateWithDuration:1.0
                     animations:^ {
                         viewController.view.alpha = 0.0;
                     } completion:^(BOOL complete) {
                         [Pilot popTopViewControllerAnimated:NO];                     
                     }];
    }

#pragma - Layout

- (void)layoutViews {
    for (UIView *v in self.view.subviews) {
        NSInteger i = [self.view.subviews indexOfObject:v];
        
        if (i == 0) {
            v.frame = CGRectMake(round(self.view.frame.size.width / 2 - v.frame.size.width / 2), 
                                10, 
                                 v.frame.size.width, 
                                 v.frame.size.height);
        } else {
            
            UIView *v0 = [self.view.subviews objectAtIndex:(i - 1)];
            
            v.frame = CGRectMake(round(self.view.frame.size.width / 2 - v.frame.size.width / 2), 
                                 round(v0.frame.origin.y + v0.frame.size.height + 10), 
                                 v.frame.size.width, 
                                 v.frame.size.height);
        }
    }
}

@end
