//
//  Post.h
//  Pilot
//
//  Created by Andrew Smith on 11/4/11.
//  Copyright (c) 2011 Pilot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Post : NSManagedObject

@property (nonatomic, retain) NSString * title;

+ (Post *)newPostInContext:(NSManagedObjectContext *)context;

@end
