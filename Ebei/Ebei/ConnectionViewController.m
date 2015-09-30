//
//  ConnectionViewController.m
//  Ebei
//
//  Created by 金瑞德科技 on 15-9-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ConnectionViewController.h"
#import "SetDataViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "NSDate+Expend.h"
#import "wtalert.h"
#import "mainViewController.h"



#import "BlueTool.h"
#import "BlueWriteTool.h"

@interface ConnectionViewController ()

@end

@implementation ConnectionViewController{
      
    __block NSString *eqNumber_;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"连接腰带";
    eqNumber_ = [NSString string];
   
    
    UIButton *left=[UIButton buttonWithType:UIButtonTypeSystem];
    left.frame = CGRectMake(0, 0, 0, 0);
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:left];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"跳过" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [btn setTitleColor:[UIColor colorWithRed:45/255.0 green:157/255.0 blue:252/255.0 alpha:1]forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 30, 20);
    [btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    
    

}
- (IBAction)bangdingyaodai:(id)sender {
    
    
//    //蓝牙开启扫描
//    [[BlueTool sharedBlueTool] startScan];
//    //开始扫描后延迟
    [self performSelector:@selector(afterDelay) withObject:nil afterDelay:5];
    
    
    [[wtalert sharedInstance]jinggao:@"绑定设备中，请稍等"];
           mainViewController *setDataCtl=[[mainViewController alloc]initWithNibName:@"mainViewController" bundle:nil];
        [self.navigationController pushViewController:setDataCtl animated:YES];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"uuid"];

}


#pragma mark - 延迟5秒后执行 查看直接连接信号最强的

-(void)afterDelay{
    
    NSDictionary *dic = [BlueTool sharedBlueTool].allRISS;
    
    if (dic.count == 0){
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设备不可见" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    if ([BlueTool sharedBlueTool].lastDevUUID) {
        [[BlueTool sharedBlueTool] connectingADevice:[BlueTool sharedBlueTool].lastDevUUID];
    }else{
        [[BlueTool sharedBlueTool] connectingADevice:dic.allKeys.lastObject];
    }
    
    
    
    
}










- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
  //状态栏为黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

}

-(void)rightClick{
    mainViewController *setDataCtl=[[mainViewController alloc]initWithNibName:@"mainViewController" bundle:nil];
    [self.navigationController pushViewController:setDataCtl animated:YES];
    
}

@end
