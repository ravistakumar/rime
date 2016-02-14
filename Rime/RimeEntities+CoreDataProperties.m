//
//  RimeEntities+CoreDataProperties.m
//  Rime
//
//  Created by rav subedi on 12/1/15.
//  Copyright © 2015 Ravi Kumar Subedi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RimeEntities+CoreDataProperties.h"

@implementation RimeEntities (CoreDataProperties)

@dynamic date;
@dynamic body;
@dynamic imageData;
@dynamic mood;
@dynamic location;

-(NSString *)sectionName{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    return [dateFormatter stringFromDate:date];
    }
@end
