//
//  Post.m
//  Pilot
//
//  Created by Andrew Smith on 11/4/11.
//  Copyright (c) 2011 Pilot. All rights reserved.
//

#import "Post.h"


@implementation Post

@dynamic title;

+ (Post *)newPostInContext:(NSManagedObjectContext *)context {
    Post *post = (Post *)[NSEntityDescription insertNewObjectForEntityForName:@"Post" 
                                                          inManagedObjectContext:context];
    
    post.title = @"The Post Title";
    [context save:nil];
    
    return post;
}

@end
