//
//  ARLNoteViewController.m
//  FinalProject
//
//  Created by Andrew Langdon on 5/2/14.
//  Copyright (c) 2014 Andrew Langdon. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "ARLNoteViewController.h"
#import "ARLNoteData.h"

@interface ARLNoteViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate,MFMailComposeViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *titleView;
@property (strong, nonatomic) ARLNoteData *note;
@property (weak, nonatomic) IBOutlet UIButton *addPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property BOOL editing;

@end

@implementation ARLNoteViewController

- (instancetype)init
{
    self = [self initWithNibName:@"ARLNoteViewController" bundle:nil];
    if (self) {
        self.note = [[ARLNoteData alloc] init];
        self.editing = false;
    }
    return self;
}

-(instancetype)initWithNote:(ARLNoteData *)note
{
    self = [self initWithNibName:@"ARLNoteViewController" bundle:nil];
    if (self) {
        self.note = note;
        self.editing = true;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    [self.addPhoto addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchDown];
    
    [self.deleteButton addTarget:self action:@selector(deleteNote:) forControlEvents:UIControlEventTouchDown];
    
    [self.emailButton addTarget:self action:@selector(emailNote:) forControlEvents:UIControlEventTouchDown];
    
    [self.titleView addTarget:self action:@selector(titleViewDidFinish:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.titleView.returnKeyType = UIReturnKeyDone;
    
    self.textView.delegate = self;

    if (self.editing){
        self.titleView.text = self.note.titleText;
        self.textView.text = self.note.body;
        self.imageView.image = self.note.image;
    }
}


-(void) takePicture:(id) sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.imageView setImage:image];
    self.note.image = self.imageView.image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)doneButtonPressed:(UIBarButtonItem *) sender
{
    
    if ([self.titleView.text isEqualToString:@""]) {
        self.titleView.text = @"Untitled";
    }
    
    self.note.body = self.textView.text;
    self.note.titleText = self.titleView.text;

    if (self.editing){
        [self.delegate inputController:self didFinishEditingNote: self.note];
    } else {
        [self.delegate inputController:self didFinishWithNote: self.note];
    }
}


-(void)titleViewDidFinish:(id)sender
{
    [self.titleView endEditing:YES];
}


-(void)deleteNote:(id)sender
{
    [self.delegate inputController: self didFinishWithDelete: self.note andWasEditing: self.editing];
}

-(void)emailNote:(id)sender
{
    MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc]init];
    mailVC.mailComposeDelegate = self;
    [mailVC setSubject:self.titleView.text];
    [mailVC setMessageBody:self.textView.text isHTML:NO];
    
    if (self.imageView.image){
        NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
        [mailVC addAttachmentData:imageData mimeType:@"image/png" fileName:@"notePhoto.png"];
    }

    
    [self presentViewController:mailVC animated:YES completion:NULL];
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
