//
//  RimeEntities+CoreDataProperties.h
//  Rime
//
//  Created by rav subedi on 12/1/15.
//  Copyright © 2015 Ravi Kumar Subedi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RimeEntities.h"

NS_ASSUME_NONNULL_BEGIN

@interface RimeEntities (CoreDataProperties)

@property (nonatomic) NSTimeInterval date;
@property (nullable, nonatomic, retain) NSString *body;
@property (nullable, nonatomic, retain) NSData *imageData;
@property (nonatomic) int16_t mood;
@property (nullable, nonatomic, retain) NSString *location;

@property (nonatomic, readonly)NSString *sectionName;


@end

NS_ASSUME_NONNULL_END
