//
//  UpdataViewController.m
//  Ebei
//
//  Created by 智恒创 on 15/9/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "UpdataViewController.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"
#import "macro.h"
@interface UpdataViewController (){
    MDRadialProgressView* progressView;
    UILabel *progressLabel;
}

@end

@implementation UpdataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backImageView=[[UIImageView alloc] init];
    backImageView.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    backImageView.image=[UIImage imageNamed:@"背景.jpg"];
    [self.view addSubview:backImageView];
    
    
    UIButton *backBtn=[[UIButton alloc] init];
    backBtn.frame=CGRectMake(3, 21, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:normal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *grayImageView=[[UIImageView alloc] initWithFrame:CGRectMake(34, 100, kScreenWidth-68, kScreenWidth-68)];
    grayImageView.image=[UIImage imageNamed:@"圈底.png"];
    [self.view addSubview:grayImageView];
    
    UIImageView *updaraImageView=[[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-68)/2-30, (kScreenWidth-68)/2-30, 60, 60)];
    updaraImageView.image=[UIImage imageNamed:@"升级完成.png"];
    [grayImageView addSubview:updaraImageView];
    
    progressView = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-68, kScreenWidth-68)];
    progressView.progressTotal = 60;  //圆分的格数
    progressView.progressCounter = 3; //有几个是白色的个子数   （跑得步数/目标步数）*圆分的总个数
    progressView.startingSlice = 1;   //初始显示位置
    progressView.theme.sliceDividerHidden = NO;
    progressView.theme.sliceDividerThickness = 1;
    
    // theme update works both changing the theme or the theme attributes
    progressView.theme.labelColor = [UIColor clearColor];
    progressView.theme.labelShadowColor = [UIColor clearColor];
    
    [grayImageView addSubview:progressView ];

    progressLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, grayImageView.frame.origin.y+kScreenWidth-68+30, kScreenWidth, 30)];
    progressLabel.text=@"已完成80%";
    progressLabel.textAlignment=NSTextAlignmentCenter;
    progressLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:progressLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

}
-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
