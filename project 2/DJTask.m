//
//  DJTask.m
//  project 2
//
//  Created by Divakaran Jeyachandran on 7/6/14.
//
//

#import "DJTask.h"

@implementation DJTask

-(id)init
{
    self = [self initWithData:nil];
    return self;
}

// Implementation of a cutom initializer
// The values are initialized through this method
-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.title = data[TASK_TITLE];
        self.description = data[TASK_DESCRIPTION];
        self.date = data[TASK_DATE];
        self.isCompleted = [data[TASK_COMPLETION]boolValue];
    }
        return self;
}

@end
