//
//  myyaodaiViewController.m
//  Ebei
//
//  Created by 李玉坤 on 15/9/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "myyaodaiViewController.h"
#import "UpdataViewController.h"

#import "ConnectionViewController.h"
#import "BlueWriteTool.h"
#import "BlueTool.h"

#import "wtalert.h"

#import "MBProgressHUD+Show.h"


@interface myyaodaiViewController ()
@property (weak, nonatomic) IBOutlet UILabel *powerLable;

@end

@implementation myyaodaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSData *data = [BlueWriteTool blueWriteToolQueryPower];
    [[BlueTool sharedBlueTool] characteristicUUID:@"000034E1-0000-1000-8000-00805F9B34FB" data:data type:2];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(power:) name:@"BlueToolPower" object:nil];
    
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blueToolPedometer:) name:@"BlueToolPedometer" object:nil];
}

-(void)power:(NSNotification *)noti{

    
    NSString *power = [NSString stringWithFormat:@"%@%%",[noti.object stringValue]];
    _powerLable.text = power;
}



#pragma mark 解绑设备
- (IBAction)unBindBtn:(UIButton *)sender {
    
    

    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastDevUUID"]) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"lastDevUUID"];
        [MBProgressHUD showSuccessWithText:@"解绑成功"];
        [[BlueTool sharedBlueTool] cancelPeripheralConnection];
        
        
        
    }else{
    
        [MBProgressHUD showSuccessWithText:@"未绑定设备"];
    }
    
    
}





- (IBAction)back_home:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)upData:(id)sender {
    UpdataViewController *upData=[[UpdataViewController alloc]init];
    [self.navigationController pushViewController:upData animated:YES];
}
- (IBAction)my_yaodai:(id)sender {
    
    
    if ([BlueTool sharedBlueTool].pre) {
//        [[wtalert sharedInstance]jinggao:@"正在同步数据 请稍等"];
        
        //获取设备号码  同步历史数据
        NSData *data = [BlueWriteTool blueWriteTool:[NSDate date]];
        [[BlueTool sharedBlueTool] characteristicUUID:@"000034E1-0000-1000-8000-00805F9B34FB" data:data type:2];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ISMAINUPDATA"];
        
    }

}

@end
