//
//  DJAddTaskViewController.m
//  project 2
//
//  Created by Divakaran Jeyachandran on 7/6/14.
//
//

#import "DJAddTaskViewController.h"

@interface DJAddTaskViewController ()

@end

@implementation DJAddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Add this line for the textview return key functionality.
    self.taskNameTextField.delegate = self;
    self.textView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField and TextView delegates

// TO leave the text view box when return key is pressed
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }else
    {
        return YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskNameTextField resignFirstResponder];
    return YES;
}

#pragma mark - Helper methods

// A healper method to get a Task object from all the fields in this ViewController
-(DJTask *)addNewTaskObject
{
    DJTask *newTask = [[DJTask alloc]init];
    newTask.title = self.taskNameTextField.text;
    newTask.description = self.textView.text;
    newTask.date = self.taskDatePicker.date;
    newTask.isCompleted = NO;
    return newTask;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Button methods

- (IBAction)cancelAddTask:(UIButton *)sender
{
    [self.delegate didCancel];
}

- (IBAction)addTask:(UIButton *)sender
{
    DJTask *newTask = [self addNewTaskObject];
    [self.delegate didAddTask:newTask];
}


@end
