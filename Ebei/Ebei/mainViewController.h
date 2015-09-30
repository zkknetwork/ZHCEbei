//
//  mainViewController.h
//  Ebei
//
//  Created by 李玉坤 on 15/9/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *low_view;
@property (weak, nonatomic) IBOutlet UILabel *jinribushu;
@property (weak, nonatomic) IBOutlet UILabel *shijian;
@property (weak, nonatomic) IBOutlet UILabel *gengxinshijian;
@property (weak, nonatomic) IBOutlet UILabel *huodongshijian;
@property (weak, nonatomic) IBOutlet UILabel *licheng;
@property (weak, nonatomic) IBOutlet UILabel *kaluli;
@property (weak, nonatomic) IBOutlet UILabel *huodong;
@property (weak, nonatomic) IBOutlet UILabel *jingzuo;
@property (weak, nonatomic) IBOutlet UIView *jiuzuoView;
@property (weak, nonatomic) IBOutlet UILabel *myGoalNum;


@property (weak, nonatomic) IBOutlet UIImageView *quanImageView;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIView *quanView;
@end
