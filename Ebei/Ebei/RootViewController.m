//
//  RootViewController.m
//  Ebei
//
//  Created by 金瑞德科技 on 15-9-7.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "RootViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "mainViewController.h"
#import "MyViewController.h"
@interface RootViewController (){
    
    __weak IBOutlet UIImageView *wenxinImgView;
    __weak IBOutlet UIImageView *qqImgView;
    __weak IBOutlet UIButton *weixinBtn;
    __weak IBOutlet UIButton *qqBtn;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (weixinBtn.selected==YES) {
        wenxinImgView.image=[UIImage imageNamed:@"微信点击.png"];
    }else{
        wenxinImgView.image=[UIImage imageNamed:@"微信.png"];

    }
    if (qqBtn.selected==YES) {
        qqImgView.image=[UIImage imageNamed:@"qq点击.png"];
    }else{
        qqImgView.image=[UIImage imageNamed:@"qq.png"];

    }

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;

}
bool flag;
- (IBAction)registerClick:(id)sender {
//    MyViewController *registerCtl=[[MyViewController alloc]initWithNibName:@"MyViewController" bundle:nil];
//    [self.navigationController pushViewController:myCtl animated:YES];

//    mainViewController *registerCtl=[[mainViewController alloc]initWithNibName:@"mainViewController" bundle:nil];
    
   RegisterViewController *registerCtl=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerCtl animated:YES];
}

- (IBAction)loginClick:(id)sender {
    LoginViewController *loginCtl=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginCtl animated:YES];

}

@end
