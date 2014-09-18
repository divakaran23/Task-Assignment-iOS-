//
//  DJEditTaskViewController.h
//  project 2
//
//  Created by Divakaran Jeyachandran on 7/6/14.
//
//

#import <UIKit/UIKit.h>
#import "DJTask.h"

@protocol DJEditTaskViewControllerDelegate <NSObject>

@required
-(void)didSave;

@end

@interface DJEditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <DJEditTaskViewControllerDelegate> delegate;
- (IBAction)saveTaskBarButton:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;
@property (strong, nonatomic) IBOutlet UITextView *textViewField;

@property (strong, nonatomic) DJTask *getTaskData;

@end
