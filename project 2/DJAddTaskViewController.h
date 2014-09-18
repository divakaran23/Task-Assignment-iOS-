//
//  DJAddTaskViewController.h
//  project 2
//
//  Created by Divakaran Jeyachandran on 7/6/14.
//
//

#import <UIKit/UIKit.h>
#import "DJTask.h"

// Write a protocol to give functionality to cancel and addTask buttons
@protocol DJAddTaskViewControllerDelegate <NSObject>

@required
-(void)didCancel;
-(void)didAddTask:(DJTask *)task;

@end

@interface DJAddTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

// Create a delegate property for the protocol
@property (weak, nonatomic) id <DJAddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *cancelAddTask;
- (IBAction)cancelAddTask:(UIButton *)sender;
- (IBAction)addTask:(UIButton *)sender;

@end
