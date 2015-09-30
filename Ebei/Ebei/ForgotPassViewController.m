//
//  ForgotPassViewController.m
//  Ebei
//
//  Created by 金瑞德科技 on 15-9-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ForgotPassViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "NETWork.h"
#import "HUDHelper.h"

@interface ForgotPassViewController ()
- (IBAction)loginClick:(id)sender;
- (IBAction)registerClick:(id)sender;

@end

@implementation ForgotPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (IBAction)sure_Btn:(id)sender {
    
    
    if ([_phoneTextField.text isEqualToString:@""]) {
        [HUDHelper showMessag:@"请输入手机号码"];
        return;
    }
    if (![self isMobileNumber:_phoneTextField.text]) {
         [HUDHelper showMessag:@"请输入有效手机号码"];
        return;
    }
    
    if ([_codeTextField.text isEqualToString:@""]) {
         [HUDHelper showMessag:@"请输入验证码"];
        return;
    }
    if (_pwdTextField.text.length<6) {
         [HUDHelper showMessag:@"密码不少于六位数"];
        return;
    }
    
    
    NSString *str=[NSString stringWithFormat:@"http://112.74.27.169:8001/ebelt/login/forget_pass?phone=%@&sms_code=%@&newpass=%@",_phoneTextField.text,_codeTextField.text,_pwdTextField.text];
    
    [NETWork  request:str Success:^(NSDictionary *mdoel) {
        
        NSLog(@"===-=--=--%@",mdoel);
        
        if ([[mdoel objectForKey:@"msg"] isEqualToString:@"succeed"]) {
            [HUDHelper showMessag:@"修改成功,请登录"];
            
            LoginViewController *loginCtl=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginCtl animated:YES];
        }else{
            
        }
        
       
        
    } failed:^(NSError *error) {
        
    }];

    
    
    
}
- (IBAction)get_code_number:(id)sender {
    
    
    
    if ([_phoneTextField.text isEqualToString:@""]) {
        
        return;
    }
    if (![self isMobileNumber:_phoneTextField.text]) {
        return;
    }
    
    NSString *str=[NSString stringWithFormat:@"http://112.74.27.169:8001/ebelt/login/forget_pass?phone=%@",_phoneTextField.text];
    
    
    [NETWork  request:str Success:^(NSDictionary *mdoel) {
        if ([[mdoel objectForKey:@"msg"] isEqualToString:@"succeed"]) {
            [HUDHelper showMessag:@"获取验证码成功,请稍后..."];
            
          
        }else{
            
        }
        
        NSLog(@"===-=--=--%@",mdoel);
        //        [hud hide:YES];
    } failed:^(NSError *error) {
        
    }];

}

- (IBAction)loginClick:(id)sender {
    LoginViewController *loginCtl=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginCtl animated:YES];

}

- (IBAction)registerClick:(id)sender {
    RegisterViewController *registerCtl=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerCtl animated:YES];

}
#pragma mark ----判断电话号码的正则
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-35-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphp = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if ([regextestmobile evaluateWithObject:mobileNum]
        || [regextestcm evaluateWithObject:mobileNum]
        || [regextestct evaluateWithObject:mobileNum]
        || [regextestcu evaluateWithObject:mobileNum]
        || [regextestphp evaluateWithObject:mobileNum])
    {
        if([regextestcm evaluateWithObject:mobileNum])
        {
            NSLog(@"China Mobile");
        }
        else if([regextestct evaluateWithObject:mobileNum])
        {
            NSLog(@"China Telecom");
        }
        else if ([regextestcu evaluateWithObject:mobileNum])
        {
            NSLog(@"China Unicom");
        }
        else if ([regextestphp evaluateWithObject:mobileNum])
        {
            NSLog(@"China ");
        }
        else
        {
            NSLog(@"Unknow Number");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}

@end

