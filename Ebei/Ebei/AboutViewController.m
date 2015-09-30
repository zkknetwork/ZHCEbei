//
//  AboutViewController.m
//  Ebei
//
//  Created by 金瑞德科技 on 15-9-11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController (){
    
    __weak IBOutlet UILabel *aboutLabel;
}

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;

     self.title=@"关于我们";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    aboutLabel.text=@"   “一贝科技”是由一帮有梦想与有激情的人组成！希望可以帮助更多的人改善生活习惯，提高生活质量。\n   “一贝科技”是2015年上线的，是专门为“一贝科技是由一帮”有梦想与有激情的人组成！希望可以帮助更多的人改善生活习惯，提高生活质量。\n   “一贝科技”是2015年上线的，是专门为“一贝科技是由一帮”有梦想与有激情的人组成！希望可以帮助更多的人改善生活习惯，提高生活质量。";
    
}

- (IBAction)back_home:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
