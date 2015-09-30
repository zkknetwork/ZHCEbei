//
//  EmailRegisterViewController.m
//  Ebei
//
//  Created by 金瑞德科技 on 15-9-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "EmailRegisterViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface EmailRegisterViewController ()
- (IBAction)loginClick:(id)sender;
- (IBAction)phoneRgisterClick:(id)sender;

@end

@implementation EmailRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (IBAction)loginClick:(id)sender {
    LoginViewController *loginCtl=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginCtl animated:YES];
}

- (IBAction)phoneRgisterClick:(id)sender {
    RegisterViewController *registerCtl=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerCtl animated:YES];
}
@end
