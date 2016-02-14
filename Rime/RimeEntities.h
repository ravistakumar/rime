//
//  RimeEntities.h
//  Rime
//
//  Created by rav subedi on 12/1/15.
//  Copyright © 2015 Ravi Kumar Subedi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int16_t, rimeEntryMood) {
    rimeEntryMoodGood = 0,
    rimeEntryMoodAverage = 1,
    rimeEntryMoodBad = 2,
};

@interface RimeEntities : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "RimeEntities+CoreDataProperties.h"
