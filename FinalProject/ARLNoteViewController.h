//
//  ARLNoteViewController.h
//  FinalProject
//
//  Created by Andrew Langdon on 5/2/14.
//  Copyright (c) 2014 Andrew Langdon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLNoteData.h"

@class ARLNoteViewController;

@protocol ARLNoteViewControllerDelegate <NSObject>

-(void)inputController:(ARLNoteViewController *) controller
     didFinishWithNote: (ARLNoteData *) note;

-(void)inputController:(ARLNoteViewController *) controller
     didFinishEditingNote: (ARLNoteData *) note;

-(void)inputController:(ARLNoteViewController *) controller
   didFinishWithDelete: (ARLNoteData *) note andWasEditing:(BOOL) editing;


@end

@interface ARLNoteViewController : UIViewController <UITextViewDelegate>

-(instancetype)initWithNote:(ARLNoteData *) note;

@property (nonatomic, weak) id<ARLNoteViewControllerDelegate> delegate;

@end
