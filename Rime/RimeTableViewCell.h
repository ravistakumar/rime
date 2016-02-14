//
//  RimeTableViewCell.h
//  Rime
//
//  Created by rav subedi on 12/3/15.
//  Copyright © 2015 Ravi Kumar Subedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RimeEntities;

@interface RimeTableViewCell : UITableViewCell

+ (CGFloat)heightForEntities: (RimeEntities *)entities;

- (void)configureCellForEntities: (RimeEntities *)entities;

@end
