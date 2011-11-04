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
    NSString *objectMessage;
}

@property (nonatomic, copy) NSString *objectMessage;

- (id)initWithObjectURI:(NSURL *)objectURI;

/**
 * Convenience function to automatically layout buttons and titles
 */
- (void)layoutViews;

@end
