//
//  DJTask.h
//  project 2
//
//  Created by Divakaran Jeyachandran on 7/6/14.
//
//

#import <Foundation/Foundation.h>

@interface DJTask : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL isCompleted;

// Define a custin initializer for the App

-(id)initWithData:(NSDictionary *)data;

@end
