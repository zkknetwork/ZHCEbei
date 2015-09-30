//
//  LoginViewController.h
//  Ebei
//
//  Created by 金瑞德科技 on 15-9-7.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)registerClick:(id)sender;
- (IBAction)forgotPassClick:(id)sender;
- (IBAction)connectionClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end
