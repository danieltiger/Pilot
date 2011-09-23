//
//  PTTestViewController.m
//  Pilot
//
//  Created by Andrew Smith on 9/23/11.
//  Copyright (c) 2011 Pilot. All rights reserved.
//

#import "PTTestViewController.h"
#import "Pilot/Pilot.h"

@implementation PTTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    // Title
    UILabel *titleLabel = [[[UILabel alloc] init] autorelease];
    titleLabel.text = NSStringFromClass([self class]);
    [titleLabel sizeToFit];
    [self.view addSubview:titleLabel];

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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma - Target-Action

- (void)redButtonAction {
    // do some cool Pilot shit
}

- (void)greenButtonAction {
    // do some cool Pilot shit
}

- (void)blueButtonAction {
    // do some cool Pilot shit
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
                                 round(v0.frame.origin.y + v.frame.size.height + 20), 
                                 v.frame.size.width, 
                                 v.frame.size.height);
        }
    }
}

@end
