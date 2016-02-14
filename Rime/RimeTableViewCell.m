//
//  RimeTableViewCell.m
//  Rime
//
//  Created by rav subedi on 12/3/15.
//  Copyright © 2015 Ravi Kumar Subedi. All rights reserved.
//

#import "RimeTableViewCell.h"
#import "RimeEntities.h"
#import <QuartzCore/QuartzCore.h>

@interface RimeTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *moodImageView;

@end

@implementation RimeTableViewCell

+(CGFloat)heightForEntities:(RimeEntities *)entities{
    const CGFloat topMargin = 35.0f;
    const CGFloat bottomMargin = 80.0f;
    const CGFloat minHeight = 106.0f;
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGRect boundingBox = [entities.body boundingRectWithSize:CGSizeMake(202, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:nil];
    return MAX(minHeight, CGRectGetHeight(boundingBox) + topMargin + bottomMargin);
    
    }
- (void)configureCellForEntities:(RimeEntities *)entities{
    self.bodyLabel.text = entities.body;
    self.locationLabel.text = entities.location;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:entities.date];
    self.dateLabel.text = [dateFormatter stringFromDate:date];
    
    if (entities.imageData) {
        self.mainImageView.image = [UIImage imageWithData:entities.imageData];
    } else {
        self.mainImageView.image = [UIImage imageNamed:@"icn_noimage"];
    }
    
    if (entities.mood == rimeEntryMoodGood) {
        self.moodImageView.image = [UIImage imageNamed:@"icn_happy"];
    } else if (entities.mood == rimeEntryMoodAverage) {
        self.moodImageView.image = [UIImage imageNamed:@"icn_average"];
    } else if (entities.mood == rimeEntryMoodBad) {
        self.moodImageView.image = [UIImage imageNamed:@"icn_bad"];
    }
    
    self.mainImageView.layer.cornerRadius = CGRectGetWidth(self.mainImageView.frame)/4.0f;
    
    if (entities.location > 0) {
        self.locationLabel.text = entities.location;
    } else {
        self.locationLabel.text = @"somewhere on the Earth🌍";
    }
    
}


@end
