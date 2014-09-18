//
//  DJViewController.h
//  project 2
//
//  Created by Divakaran Jeyachandran on 7/6/14.
//
//

#import <UIKit/UIKit.h>
#import "DJAddTaskViewController.h"
#import "DJDetailTaskViewController.h"
#import "DJEditTaskViewController.h"

@interface DJViewController : UIViewController <DJAddTaskViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, DJDetailTaskViewControllerDelegate>

- (IBAction)reOrderTaskBarButton:(UIBarButtonItem *)sender;
- (IBAction)addTasBarButton:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

// Property for accessing the TaskObjects
@property (strong, nonatomic) NSMutableArray *taskObjects;

@end
