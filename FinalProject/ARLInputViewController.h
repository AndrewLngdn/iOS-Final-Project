//
//  ARLInputViewController.h
//  FinalProject
//
//  Created by Andrew Langdon on 5/1/14.
//  Copyright (c) 2014 Andrew Langdon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARLInputViewController;

@protocol ARLInputViewControllerDelegate <NSObject>

-(void)inputController:(ARLInputViewController *) controller
     didFinishWithText: (NSString *) text;

@end

@interface ARLInputViewController : UIViewController

@property (nonatomic, weak) id<ARLInputViewControllerDelegate> delegate;

@end
