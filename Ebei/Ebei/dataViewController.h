//
//  dataViewController.h
//  Ebei
//
//  Created by 李玉坤 on 15/9/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dataViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *base_view;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
