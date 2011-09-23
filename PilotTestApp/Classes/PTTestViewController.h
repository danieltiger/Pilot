//
//  PTTestViewController.h
//  Pilot
//
//  Created by Andrew Smith on 9/23/11.
//  Copyright (c) 2011 Pilot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTTestObject.h"

@interface PTTestViewController : UIViewController {
@private
    PTTestObject *object;
}

@property (nonatomic, retain) PTTestObject *object;

/**
 * Convenience function to automatically layout buttons and titles
 */
- (void)layoutViews;

@end
