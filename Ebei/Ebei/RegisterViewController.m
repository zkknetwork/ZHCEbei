//
//  RegisterViewController.m
//  Ebei
//
//  Created by 金瑞德科技 on 15-9-7.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "EmailRegisterViewController.h"
#import "ConnectionViewController.h"
#import "NETWork.h"
#import "HUDHelper.h"
@interface RegisterViewController (){
    NSString *codeNumber;
}
- (IBAction)emailRegisterClick:(id)sender;

- (IBAction)loginClick:(id)sender;
- (IBAction)registerClick:(id)sender;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (IBAction)emailRegisterClick:(id)sender {
    EmailRegisterViewController *emailCtl=[[EmailRegisterViewController alloc]initWithNibName:@"EmailRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:emailCtl animated:YES];

}

- (IBAction)loginClick:(id)sender {
    LoginViewController *loginCtl=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginCtl animated:YES];
}
- (IBAction)getCode_num:(id)sender {
    
    
    if ([_phoneTextField.text isEqualToString:@""]) {
        [HUDHelper showMessag:@"请输入手机号码"];
        return;
    }
    if (![self isMobileNumber:_phoneTextField.text]) {
        [HUDHelper showMessag:@"请输入有效手机号码"];
        return;
        
    }
    
    NSString *str=[NSString stringWithFormat:@"http://112.74.27.169:8001/ebelt/login/registe?phone=%@",_phoneTextField.text];

    
    [NETWork  request:str Success:^(NSDictionary *mdoel) {
        if ([[mdoel objectForKey:@"msg"] isEqualToString:@"succeed"]) {
            [HUDHelper showMessag:@"获取验证码成功..."];
            
            
        }else{
            
        }
        NSLog(@"===-=--=--%@",mdoel);
//        [hud hide:YES];
    } failed:^(NSError *error) {
        
    }];
    
    
   
   
}

- (IBAction)registerClick:(id)sender {
    
    
      if ([_phoneTextField.text isEqualToString:@""]) {
     [HUDHelper showMessag:@"请输入手机号码"];
        return;
    }
    if (![self isMobileNumber:_phoneTextField.text]) {
        [HUDHelper showMessag:@"请输入有效手机号码"];
        return;
    }
    
    if ([_codeTwxtField.text isEqualToString:@""]) {
        [HUDHelper showMessag:@"请输入验证码"];
        return;
    }
    if (_pwdTextField.text.length<6) {
        [HUDHelper showMessag:@"密码不少于六位数"];
        return;
    }

    
    NSString *str=[NSString stringWithFormat:@"http://112.74.27.169:8001/ebelt/login/registe?phone=%@&sms_code=%@&password=%@",_phoneTextField.text,_codeTwxtField.text,_pwdTextField.text];
    
    [NETWork  request:str Success:^(NSDictionary *mdoel) {
        
        if ([[mdoel objectForKey:@"msg"] isEqualToString:@"succeed"]) {
            [HUDHelper showMessag:@"注册成功,请登录"];
            LoginViewController *loginCtl=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginCtl animated:YES];
        }else{
            
        }
        
        NSLog(@"===-=--=--%@",mdoel);
        
    } failed:^(NSError *error) {
        
    }];

//    ConnectionViewController *connectionCtl=[[ConnectionViewController alloc]initWithNibName:@"ConnectionViewController" bundle:nil];
//    [self.navigationController pushViewController:connectionCtl animated:YES];
}

#pragma mark ----判断字母数字混合
-(BOOL)isValidateMath:(NSString *)math
{
    NSString *regex = @".*[a-zA-Z].*[0-9]|.*[0-9].*[a-zA-Z]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:math];
    
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

