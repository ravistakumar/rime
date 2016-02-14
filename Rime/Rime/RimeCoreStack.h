//
//  RimeCoreStack.h
//  Rime
//
//  Created by rav subedi on 12/1/15.
//  Copyright © 2015 Ravi Kumar Subedi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface RimeCoreStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(instancetype)defaultStack;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;
@end
