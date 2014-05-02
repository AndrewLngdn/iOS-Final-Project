//
//  ARLNoteViewController.m
//  FinalProject
//
//  Created by Andrew Langdon on 5/2/14.
//  Copyright (c) 2014 Andrew Langdon. All rights reserved.
//

#import "ARLNoteViewController.h"
#import "ARLNoteData.h"

@interface ARLNoteViewController ()


@property (weak, nonatomic) IBOutlet UITextView *textView;


@property (weak, nonatomic) IBOutlet UITextField *titleView;

@property (strong, nonatomic) ARLNoteData *note;

@end

@implementation ARLNoteViewController

- (instancetype)init
{

    self = [self initWithNibName:@"ARLNoteViewController" bundle:nil];
    if (self) {
//        self.note = [[ARLNoteData alloc] init];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.titleView addTarget:self
                       action:@selector(textFieldDidFinish:)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.titleView.returnKeyType = UIReturnKeyDone;
    
    
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDone;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"did end editing");
}



-(void)titleDidFinish:(UITextField *)title
{
    NSLog(@"in title did finish");
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
