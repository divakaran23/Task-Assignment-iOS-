//
//  DJDetailTaskViewController.h
//  project 2
//
//  Created by Divakaran Jeyachandran on 7/6/14.
//
//

#import <UIKit/UIKit.h>
#import "DJTask.h"
#import "DJEditTaskViewController.h"

@protocol DJDetailTaskViewControllerDelegate <NSObject>

@required
-(void)updateEdition;

@end

@interface DJDetailTaskViewController : UIViewController <DJEditTaskViewControllerDelegate>
- (IBAction)editTaskBarButton:(UIBarButtonItem *)sender;

@property (weak, nonatomic) id <DJDetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tastDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;

@property (strong, nonatomic) DJTask *detailTaskObject;

@end
