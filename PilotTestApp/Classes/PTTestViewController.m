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

- (void)dealloc {
    [objectMessage release];
    
    [super dealloc];
}

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
    UILabel *objectMessageLabel = [[[UILabel alloc] init] autorelease];
    objectMessageLabel.numberOfLines = 0;
    objectMessageLabel.text = self.objectMessage;
    
    CGSize size = [self.objectMessage sizeWithFont:[objectMessageLabel font] 
                            constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:UILineBreakModeTailTruncation];
    objectMessageLabel.frame = CGRectMake(0, 0, size.width, size.height);  
    [self.view addSubview:objectMessageLabel];
    
    // Red
    UIButton *redButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [redButton setTitle:@"Show Red" forState:UIControlStateNormal];
    [redButton addTarget:self action:@selector(redButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [redButton sizeToFit];
    [self.view addSubview:redButton];
    
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
    [Pilot showObject:newRedObject animation:UIViewAnimationOptionTransitionCurlDown duration:0.8];
}

- (void)greenButtonAction {
    GreenObject *newGreenObject = [GreenObject objectWithUniqueMessage];
    [Pilot showObject:newGreenObject];
}

- (void)blueButtonAction {
    BlueObject *newBlueObject = [BlueObject objectWithUniqueMessage];
    [Pilot showObject:newBlueObject];
}

#pragma - Layout

- (void)layoutViews {
    for (UIView *v in self.view.subviews) {
        NSInteger i = [self.view.subviews indexOfObject:v];
        
        if (i == 0) {
            v.frame = CGRectMake(round(self.view.frame.size.width / 2 - v.frame.size.width / 2), 
                                 round(v.frame.size.height + 20), 
                                 v.frame.size.width, 
                                 v.frame.size.height);
        } else {
            
            UIView *v0 = [self.view.subviews objectAtIndex:(i - 1)];
            
            v.frame = CGRectMake(round(self.view.frame.size.width / 2 - v.frame.size.width / 2), 
                                 round(v0.frame.origin.y + v0.frame.size.height + 20), 
                                 v.frame.size.width, 
                                 v.frame.size.height);
        }
    }
}

@end
