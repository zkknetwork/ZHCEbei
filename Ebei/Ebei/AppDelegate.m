//
//  AppDelegate.m
//  Ebei
//
//  Created by 金瑞德科技 on 15-9-7.
//  Copyright (c) 2015年 mac. All rights reserved.
//


#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "ConnectionViewController.h"

#import "RootViewController.h"
#import "CJNavigationController.h"
#import "SetDataViewController.h"
#import "ConnectionViewController.h"

#import "BlueTool.h"
#import "BlueWriteTool.h"
#import "NETWork.h"
#import "HUDHelper.h"


#import "MBProgressHUD+Show.h"


@interface AppDelegate ()<BlueToolDelegate>{

    //响应数据
    NSMutableData *_responseData;   //中间部分的数据
    NSData *_endData;
    
    
    
    
    //同步的天数
    int countDay;
    NSData *_deviceNo;  //获取设备号的结尾
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
   
    
    
    if (phone&&password) {

                //存储用户信息
                NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                [userDefaults setObject:phone forKey:@"phone"];//用户
                [userDefaults setObject:password forKey:@"pwd"];//用户密码
                
                [userDefaults synchronize];
                
        
            ConnectionViewController *root=[[ConnectionViewController alloc]initWithNibName:@"ConnectionViewController" bundle:nil];
            CJNavigationController *baseNav=[[CJNavigationController alloc]initWithRootViewController:root];
                //去掉导航栏黑线
                [baseNav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
                baseNav.navigationBar.shadowImage = [[UIImage alloc] init];
                
                    self.window.rootViewController=baseNav;

    }else{
        
        RootViewController *root=[[RootViewController alloc]initWithNibName:@"RootViewController" bundle:nil];
       CJNavigationController* baseNav=[[CJNavigationController alloc]initWithRootViewController:root];
        
        //去掉导航栏黑线
        [baseNav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        baseNav.navigationBar.shadowImage = [[UIImage alloc] init];
        
        self.window.rootViewController=baseNav;

    }
    
    
    
    
    
    [self.window makeKeyAndVisible];
    
    
    //初始化sdk
    [ShareSDK registerApp:@"957947259a60"];
    
    
          //qq分享  //该参数填入申请的QQ AppId
        [ShareSDK connectQQWithQZoneAppKey:@"101107172"
                         qqApiInterfaceCls:[QQApiInterface class]
                           tencentOAuthCls:[TencentOAuth class]];
        //qq和空间
        [ShareSDK connectQZoneWithAppKey:@"101107172"
                               appSecret:@"eccbe28091dc5f1520731e66c842281b"
                       qqApiInterfaceCls:[QQApiInterface class]
                         tencentOAuthCls:[TencentOAuth class]];
    
        //导入QQ互联和QQ好友分享需要的外部库类型，如果不需要QQ空间SSO和QQ好友分享可以不调用此方法
        [ShareSDK importQQClass:[QQApiInterface class]
                tencentOAuthCls:[TencentOAuth class]];
    
    
    //添加微信应用
        [ShareSDK connectWeChatWithAppId:@"wxeb102a06c4578f93"        //此参数为申请的微信AppID
                               wechatCls:[WXApi class]];
    
        [ShareSDK connectWeChatTimelineWithAppId:@"wxeb102a06c4578f93" wechatCls:[WXApi class]];
    
        //导入微信需要的外部库类型，如果不需要微信分享可以不调用此方法
        [ShareSDK importWeChatClass:[WXApi class]];
    
    //微信登陆的时候需要初始化
    [ShareSDK connectWeChatWithAppId:@"wxeb102a06c4578f93"
                           appSecret:@"feebab0c8b1cb59decee6bc775c72db5"
                           wechatCls:[WXApi class]];
    
    
    [ShareSDK connectCopy];
    
    
    
    
    
    
    
    
    
    
    
    
    //开启蓝牙扫描
    [self blueToolShared];
    
    
    
//    BOOL isOn = [BlueTool sharedBlueTool].isOn;
//    
//    if (isOn == NO) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"蓝牙没有打开" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//        [alert show];
//    }
    
    
    countDay = 0;
    
    
    [[BlueTool sharedBlueTool] hardwareResponseStatus:^(CBPeripheral *peripheral, STATUS status) {
        switch (status) {
            case STATUS_CONNECTED: //连接成功
                break;
            case STATUS_UPDATEPRE: //刷新出了可见设备
                break;
            case STATUS_DISCONNECTED: //断开连接
                
                
//                [[BlueTool sharedBlueTool] startScan];
                break;
            default:
                break;
        }
    }];
    
    
    
    
    
    

    return YES;
}




//-(void)syn:(UIButton *)btn{
//    
//    if (btn.tag == 1) {      //查询计步
//        
//        NSData *data = [BlueWriteTool blueWriteTool:[NSDate date]];
//        
//        [[BlueTool sharedBlueTool] characteristicUUID:@"000034E1-0000-1000-8000-00805F9B34FB" data:data type:2];
//        
//    }else if(btn.tag == 2){  //查询电量
//        
//        NSData *data = [BlueWriteTool blueWriteToolQueryPower];
//        [[BlueTool sharedBlueTool] characteristicUUID:@"000034E1-0000-1000-8000-00805F9B34FB" data:data type:2];
//        
//    }else if(btn.tag == 3){  //久坐设置
//        
//        NSData *data = [BlueWriteTool blueWriteToolsedentaryReminder:1 timeInterval:@"01:00" starTime:@"00:01" endTime:@"23:59"];
//        [[BlueTool sharedBlueTool] characteristicUUID:@"000034E1-0000-1000-8000-00805F9B34FB" data:data type:2];
//    }
//}




#pragma mark - 创建并初始化蓝牙工具

-(void)blueToolShared{
    
    BlueTool *blue = [BlueTool sharedBlueTool];
    
    NSArray *UUIDs1 = @[[CBUUID UUIDWithString:@"000034E1-0000-1000-8000-00805F9B34FB"],
                        [CBUUID UUIDWithString:@"000034E2-0000-1000-8000-00805F9B34FB"]];
    
    NSArray *UUIDs2 = @[[CBUUID UUIDWithString:@"9D84B9A3-000C-49D8-9183-855B673FDA31"],
                        [CBUUID UUIDWithString:@"6C53DB25-47A1-45FE-A022-7C92FB334FD4"],
                        [CBUUID UUIDWithString:@"724249F0-5EC3-4B5F-8804-42345AF08651"],
                        [CBUUID UUIDWithString:@"8082CAA8-41A6-4021-91C6-56F9B954CC34"],
                        [CBUUID UUIDWithString:@"457871E8-D516-4CA1-9116-57D0B17B9CB2"],
                        [CBUUID UUIDWithString:@"5F78DF94-798C-46F5-990A-B3EB6A065C88"]];
    
    
    blue.characteristics = @{UUIDs1:SERVECE1_UUID,UUIDs2:SERVECE2_UUID};
    
    blue.letWriteUUIDs = @[@"000034E1-0000-1000-8000-00805F9B34FB"];
    
    blue.letReadUUIDs = @[@"000034E2-0000-1000-8000-00805F9B34FB"];
    
    blue.letNotiUUIDs = @[@"000034E2-0000-1000-8000-00805F9B34FB"];
    
    
    //代理或block 二选一
    blue.delegate = self;
    
    
    [[BlueTool sharedBlueTool] startScan];
    
}

-(void)blueToolPeripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic{
    
    NSLog(@"代理 %@  %@   %@   ",peripheral.identifier.UUIDString, characteristic.UUID.UUIDString,characteristic.value);
    
    
    
    NSString *UUIDString = characteristic.UUID.UUIDString;
    
    NSData *data = characteristic.value;
    NSUInteger length = data.length;
    unsigned char *bytes = malloc(length);
    [data getBytes:bytes];
    
    if ([UUIDString isEqualToString:@"000034E1-0000-1000-8000-00805F9B34FB"]) {  //读
        
        
    }else if ([UUIDString isEqualToString:@"000034E2-0000-1000-8000-00805F9B34FB"]) {  //通知
        
        
        if ((bytes[0] == 0x5b) && (bytes[1] == 0x0d)) {       //1 电量值
            
            NSLog(@"电量值  %d",bytes[4]);
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BlueToolPower" object:@(bytes[4])];
            
            
        }
        
        
        
        if ((bytes[0] == 0x5b) && (bytes[1] == 0x01) && (bytes[2]==0x00)) {        // 2 计步 数据
            
            
            //第一天的数据
            
//            NSDate *date = [NSDate dateWithTimeInterval:- countDay * 24 * 3600 sinceDate:[NSDate date]];
            
            _deviceNo = data;
            
            NSData *writeData = [BlueWriteTool blueWriteToolStar:[NSDate date] endDate:nil data:data];    //按照日期去读取数据
            [[BlueTool sharedBlueTool] characteristicUUID:@"000034E1-0000-1000-8000-00805F9B34FB" data:writeData type:2];
            
            
            
            
            //  请求数据了先滞空
            _responseData = [NSMutableData data];
            
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            HUD.labelText = @"正在同步...";
            
            [self performSelector:@selector(afterDelay:) withObject:HUD afterDelay:10];
        }
        
        
        if ((bytes[0] == 0x5a) && (bytes[1] == 0x05)) {      //返回响应数据包
            
            if (bytes[2] == 0x01) {        //包头  告诉你有多少字节
                
                NSLog(@"告诉你有多少字节  %d",bytes[4]);
                
            }else if (bytes[2] == 0xfe || bytes[2] == 0xff){   //结尾  最后一条数据
                
                //                        NSData *dataSegment = [data subdataWithRange:NSMakeRange(3, (length - 3))];这个地方直接拼接会有问题 每次连接都会调用
                //                        [_responseData appendData:dataSegment];
                
                _endData = [data subdataWithRange:NSMakeRange(3, (length - 3))];
                
                
                
                if (_responseData.length) {              //如果 有长度就是历史数据  就做最后拼接
                    
                    [_responseData appendData:_endData];
                    
                    NSDate *hisdate = [NSDate dateWithTimeInterval:- (countDay) * 24 * 3600 sinceDate:[NSDate date]];
                    NSDictionary *info = @{@"date":hisdate,@"_responseData":_responseData};
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"BlueToolPedometer" object:nil userInfo:info];
                    
                    
                    countDay++;
                    
                    
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ISMAINUPDATA"]) {
                        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ISMAINUPDATA"];
                        countDay = 0;
                        
                        
                        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                        [MBProgressHUD showSuccessWithText:@"同步完成"];
                        _responseData = [NSMutableData data];
                        return;
                    }
                    
                    if (countDay >= 5) {
                        countDay = 0;
                        
                        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                        [MBProgressHUD showSuccessWithText:@"同步完成"];
                    }else{
                        NSDate *date = [NSDate dateWithTimeInterval:- countDay * 24 * 3600 sinceDate:[NSDate date]];
                        NSData *writeData = [BlueWriteTool blueWriteToolStar:date endDate:nil data:_deviceNo];
                        [[BlueTool sharedBlueTool] characteristicUUID:@"000034E1-0000-1000-8000-00805F9B34FB" data:writeData type:2];
                    }
                    
                    //  请求数据了先滞空
                    _responseData = [NSMutableData data];
                    
                    
                    
//                    NSUInteger _responseDataLength = _responseData.length;
//                    
//                    for (int i = 0; i < _responseData.length; i++) {
//                        
//                        int loca = i * 2;
//                        
//                        NSRange range = NSMakeRange(loca, 2);
//                        
//                        if (loca >= _responseDataLength) {  //越界了
//                            continue;
//                        }else if(loca + 2 >= _responseDataLength){
//                            range = NSMakeRange(loca, 1);
//                        }
//                        
//                        
//                        NSData *subData = [_responseData subdataWithRange:range];
//                        
//                        NSUInteger length = subData.length;
//                        unsigned char *subBytes = malloc(length);
//                        [subData getBytes:subBytes];
//                        
//                        int numberTwoBytes = (subBytes[0] << 8) + subBytes[1];
//                        int time = (i + 1) * 30;
//                        NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d",(time/60)%24,time%60];
//                        
//                        NSLog(@"numberTwoBytes  =  %d   count = %d     time = %@",numberTwoBytes,(i + 1),timeStr);
//                        
//                    }
                    
                }
                
            }else{                         //中间的数据
                
                NSData *dataSegment = [data subdataWithRange:NSMakeRange(3, (length - 3))];
                [_responseData appendData:dataSegment];
            }
        }
        
        
    }
}


-(void)afterDelay:(MBProgressHUD *)hud{
    [hud hide:YES];
}

@end
