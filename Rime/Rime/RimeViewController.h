//
//  ViewController.h
//  Rime
//
//  Created by rav subedi on 12/1/15.
//  Copyright © 2015 Ravi Kumar Subedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RimeEntities;

@interface RimeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;


@property(nonatomic, strong)RimeEntities *entitie;

@end

