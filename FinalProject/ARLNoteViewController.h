//
//  ARLNoteViewController.h
//  FinalProject
//
//  Created by Andrew Langdon on 5/2/14.
//  Copyright (c) 2014 Andrew Langdon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARLNoteViewController;

@protocol ARLNoteViewControllerDelegate <NSObject>

-(void)inputController:(ARLNoteViewController *) controller
     didFinishWithText: (NSString *) text;

@end

@interface ARLNoteViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, weak) id<ARLNoteViewControllerDelegate> delegate;

@end
