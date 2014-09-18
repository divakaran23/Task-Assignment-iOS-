//
//  DJDetailTaskViewController.m
//  project 2
//
//  Created by Divakaran Jeyachandran on 7/6/14.
//
//

#import "DJDetailTaskViewController.h"

@interface DJDetailTaskViewController ()

@end

@implementation DJDetailTaskViewController

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
    self.taskNameLabel.text = self.detailTaskObject.title;
    self.tastDescriptionLabel.text = self.detailTaskObject.description;
    
    NSDate *date = self.detailTaskObject.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateFromString = [formatter stringFromDate:date];
    
    self.taskDateLabel.text = dateFromString;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[DJEditTaskViewController class]]) {
        DJEditTaskViewController *targetController = segue.destinationViewController;
       
        targetController.getTaskData = self.detailTaskObject;
        targetController.delegate = self;
    }
//    if ([segue.destinationViewController isKindOfClass:[DJEditTaskViewController class]]) {
//        DJEditTaskViewController *targetController = segue.destinationViewController;
//        targetController.delegate = self;
//    }
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

- (IBAction)editTaskBarButton:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"editTaskSegue" sender:sender];
}

#pragma mark - Delegate method

-(void)didSave
{
    self.taskNameLabel.text = self.detailTaskObject.title;
    self.tastDescriptionLabel.text = self.detailTaskObject.description;
    NSDate *date = self.detailTaskObject.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateFromString = [formatter stringFromDate:date];
    self.taskDateLabel.text = dateFromString;
//    [self viewDidLoad];
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate updateEdition];
}
@end
