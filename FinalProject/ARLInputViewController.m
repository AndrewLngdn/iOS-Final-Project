//
//  ARLInputViewController.m
//  FinalProject
//
//  Created by Andrew Langdon on 5/1/14.
//  Copyright (c) 2014 Andrew Langdon. All rights reserved.
//

#import "ARLInputViewController.h"

@interface ARLInputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ARLInputViewController

- (instancetype)init
{
    self = [self initWithNibName:@"ARLInputViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.textField addTarget:self
                       action:@selector(textFieldDidFinish:)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    self.textField.returnKeyType = UIReturnKeyDone;
    
}


- (void)textFieldDidFinish:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""]) {
        [self.delegate inputController:self didFinishWithText:textField.text];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Whoops!"
                                    message:@"You must provide a title"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}
@end
