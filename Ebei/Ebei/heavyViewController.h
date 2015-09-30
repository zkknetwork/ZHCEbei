//
//  heavyViewController.h
//  Ebei
//
//  Created by 李玉坤 on 15/9/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#
@interface heavyViewController : UIViewController
@property BOOL isman;

@property (weak, nonatomic) IBOutlet UIView *tizhong;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *myWeight;
@property (weak, nonatomic) IBOutlet UIView *redLine;
@property (weak, nonatomic) IBOutlet UILabel *backLabel;

@end
