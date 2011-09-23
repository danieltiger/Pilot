//
//  PTObject.h
//  Pilot
//
//  Created by Arik Devens on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//



@interface PTObject : NSManagedObject {
    NSString *identifier;
}

@property (nonatomic, retain) NSString *identifier;

@end
