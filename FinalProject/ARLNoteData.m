//
//  ARLNoteData.m
//  FinalProject
//
//  Created by Andrew Langdon on 5/2/14.
//  Copyright (c) 2014 Andrew Langdon. All rights reserved.
//

#import "ARLNoteData.h"



@implementation ARLNoteData

-(id)init
{
    if (self = [super init]){
        self.titleText = @"Title goes here";
        self.body = @"Note goes here!";
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject: self.titleText forKey:@"titleText"];
    [coder encodeObject: self.body forKey:@"body"];
}

-(id)initWithCoder:(NSCoder *)coder
{
    if (self = [self init]){
        self.titleText = [coder decodeObjectForKey:@"titleText"];
        self.body = [coder decodeObjectForKey:@"body"];
    }
    
    return self;
}

@end
