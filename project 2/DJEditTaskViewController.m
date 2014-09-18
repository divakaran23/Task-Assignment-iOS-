//
//  DJEditTaskViewController.m
//  project 2
//
//  Created by Divakaran Jeyachandran on 7/6/14.
//
//

#import "DJEditTaskViewController.h"

@interface DJEditTaskViewController ()

@end

@implementation DJEditTaskViewController

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
    self.taskNameTextField.text = self.getTaskData.title;
    self.textViewField.text = self.getTaskData.description;
    self.taskDatePicker.date = self.getTaskData.date;
    
    self.taskNameTextField.delegate = self;
    self.textViewField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateInformation
{
    self.getTaskData.title = self.taskNameTextField.text;
    self.getTaskData.description = self.textViewField.text;
    self.getTaskData.date = self.taskDatePicker.date;

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

- (IBAction)saveTaskBarButton:(UIBarButtonItem *)sender
{
    [self updateInformation];
    [self.delegate didSave];
}

#pragma mark - TextField and TextView delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskNameTextField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textViewField resignFirstResponder];
        return NO;
    }else
    {
        return YES;
    }
}

@end
