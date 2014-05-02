//
//  ARLStringViewController.m
//  FinalProject
//
//  Created by Andrew Langdon on 5/1/14.
//  Copyright (c) 2014 Andrew Langdon. All rights reserved.
//

#import "ARLStringViewController.h"

@interface ARLStringViewController ()

@property (nonatomic, strong) NSString *string;
@property (nonatomic) NSInteger row;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ARLStringViewController

- (instancetype)initWithRow:(NSInteger)row string:(NSString *)string
{
    if (self = [self initWithNibName:@"ARLStringViewController" bundle:nil]) {
        self.string = string;
        
        self.row = row;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%d", self.row];
    
    self.textView.text = self.string;
    
    NSLog(@"textview %@", self.textView.text);
    NSLog(@"self.string %@", self.string);
}


@end
