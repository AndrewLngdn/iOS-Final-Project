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
        self.title = @"Title goes here";
        self.body = @"Note goes here!";
    }
    return self;
}

-(void)test
{
    self.body = @"setting body";
}

@end
