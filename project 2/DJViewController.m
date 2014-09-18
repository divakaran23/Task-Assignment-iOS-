//
//  DJViewController.m
//  project 2
//
//  Created by Divakaran Jeyachandran on 7/6/14.
//
//

#import "DJViewController.h"

@interface DJViewController ()

@end

@implementation DJViewController

#pragma mark - Lazy Instantiation

-(NSMutableArray *)taskObjects
{
    if (!_taskObjects) {
        _taskObjects =  [[NSMutableArray alloc]init];
    }
    return _taskObjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *taskObjectAsPropertyList = [[NSUserDefaults standardUserDefaults]arrayForKey:TASK_OBJECTS_KEY];
    for (NSDictionary *dictionary in taskObjectAsPropertyList) {
        DJTask *task = [self taskObjectFromDictionary:dictionary];
        [self.taskObjects addObject:task];
    }
    
    // Set the tableview datasource and delegate property to self
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[DJAddTaskViewController class]]) {
        DJAddTaskViewController *targetController = segue.destinationViewController;
        targetController.delegate = self;
    }
    
    // This segue is to send data from this viewcontroller to detailedTaskViewController
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.destinationViewController isKindOfClass:[DJDetailTaskViewController class]]) {
            DJDetailTaskViewController *targetController = segue.destinationViewController;
            NSIndexPath *path = sender;
            DJTask *selectedTask = self.taskObjects[path.row];
            targetController.detailTaskObject = selectedTask;
            
            targetController.delegate = self;
//            [self.taskObjects removeObject:selectedTask];
            
        }
    }
//    if ([segue.destinationViewController isKindOfClass:[DJEditTaskViewController class]]) {
//        DJEditTaskViewController *targetController = segue.destinationViewController;
//        NSIndexPath *path = sender;
//        DJTask *selectedTask = self.taskObjects[path.row];
//        [self.taskObjects removeObject:selectedTask];
//        targetController.delegate = self;
//    }
}

// This method contains the functionality for the accessory button present in each cell
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailTaskSegue" sender:indexPath];
}

#pragma mark - Button methods

- (IBAction)reOrderTaskBarButton:(UIBarButtonItem *)sender
{
    // To set the tableview editing
    if (self.tableView.editing == NO) [self.tableView setEditing:YES animated:YES];
    else [self.tableView setEditing:NO animated:YES];
}

- (IBAction)addTasBarButton:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"addTaskSegue" sender:sender];
}

#pragma mark - Protocol methods

-(void)didCancel
{
    NSLog(@"Cancel Addition");
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)didAddTask:(DJTask *)task
{
    [self.taskObjects addObject:task];
    NSLog(@"%@", task.title);
    
    // Create a mutable array and set its property to NSUser defaults
    NSMutableArray *addedTaskObject = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASK_OBJECTS_KEY]mutableCopy];
   
    //confirm if the mutable array contains value. If not, allocate and initialize it
    if (!addedTaskObject) {
        addedTaskObject = [[NSMutableArray alloc]init];
    }
    
    /* call the method taskObjectAsAPropertyList to get a dictionary
     and add that dictionary to the above created NSMutableArray */
    [addedTaskObject addObject:[self taskObjectAsAPropertyList:task]];
    
    // Save the NSMutableArray to NSUserDefaults
    [[NSUserDefaults standardUserDefaults]setObject:addedTaskObject forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    // Dismiss the viewController when the button is pressed
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Reload the table data
    [self.tableView reloadData];
    
}

-(void)updateEdition
{
    [self saveTasks];
    [self.tableView reloadData];
}



#pragma mark - Helper methods

-(NSDictionary *)taskObjectAsAPropertyList:(DJTask *)taskObject
{
    NSDictionary *addedTaskObject = @{TASK_TITLE: taskObject.title, TASK_DESCRIPTION: taskObject.description, TASK_DATE: taskObject.date, TASK_COMPLETION: @(taskObject.isCompleted)};
    return addedTaskObject;
}

-(DJTask *)taskObjectFromDictionary:(NSDictionary *)dictionary
{
    DJTask *taskObject = [[DJTask alloc]initWithData:dictionary];
    return taskObject;
}

-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    int currentDate = [date timeIntervalSince1970];
    int dueDate = [toDate timeIntervalSince1970];
    if (currentDate > dueDate) {
        return YES;
    }else
    {
        return NO;
    }
}

-(void)updateCompletionOfTask:(DJTask *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *updatedTaskAsPropertyList = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASK_OBJECTS_KEY]mutableCopy];
    if (!updatedTaskAsPropertyList) {
        updatedTaskAsPropertyList = [[NSMutableArray alloc]init];
    }
    [updatedTaskAsPropertyList removeObjectAtIndex:indexPath.row];
    if (task.isCompleted == NO) {
        task.isCompleted = YES;
    }else
    {
        task.isCompleted = NO;
    }
    
    // Insert the updated object into the mutable array
    [updatedTaskAsPropertyList insertObject:[self taskObjectAsAPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults]setObject:updatedTaskAsPropertyList forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.tableView reloadData];
    
}

-(void)saveTasks
{
    NSMutableArray *newSavedTaskObject = [[NSMutableArray alloc]init];
    for (DJTask *taskObject in self.taskObjects) {
        [newSavedTaskObject addObject:[self taskObjectAsAPropertyList:taskObject]];
    }
    [[NSUserDefaults standardUserDefaults]setObject:newSavedTaskObject forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark - TableView methods


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskObjects count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellIdentifier forIndexPath:indexPath];
    DJTask *task = [self.taskObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = task.title;
    
    // Convert the date to a string format
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *stringFromDate = [formatter stringFromDate:task.date];
    cell.detailTextLabel.text = stringFromDate;
    
    
    BOOL due = [self isDateGreaterThanDate:[NSDate date] and:task.date];
    if (task.isCompleted == YES) {
        cell.backgroundColor = [UIColor greenColor];
    }
    else if (due == NO) {
        cell.backgroundColor = [UIColor yellowColor];
    }else
    {
        cell.backgroundColor = [UIColor redColor];
    }
//    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
//    if (task.isCompleted == YES) {
//        cell.backgroundColor = [UIColor greenColor];
//    }else
//    {
//        cell.backgroundColor = [UIColor redColor];
//    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DJTask *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
        
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        NSMutableArray *newSavedTaskObject = [[NSMutableArray alloc]init];
        for (DJTask *taskObject in self.taskObjects) {
            [newSavedTaskObject addObject:[self taskObjectAsAPropertyList:taskObject]];
        }
        [[NSUserDefaults standardUserDefaults]setObject:newSavedTaskObject forKey:TASK_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }

}

#pragma mark - Table Reorder

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    DJTask *taskToMove = [self.taskObjects objectAtIndex:sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:taskToMove atIndex:destinationIndexPath.row];
    [self saveTasks];
}

@end
