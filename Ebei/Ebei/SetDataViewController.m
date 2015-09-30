//
//  SetDataViewController.m
//  Ebei
//
//  Created by 金瑞德科技 on 15-9-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SetDataViewController.h"
#import "HeightViewController.h"

@interface SetDataViewController ()
- (IBAction)womenClick:(id)sender;
- (IBAction)manClick:(id)sender;

@end

@implementation SetDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"设定个人资料";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    
}


- (IBAction)womenClick:(id)sender {
    HeightViewController *heightCtl=[[HeightViewController alloc]initWithNibName:@"HeightViewController" bundle:nil];
    heightCtl.isman = NO;
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    [userdefault setObject:@"1" forKey:@"sender"];
    [userdefault synchronize];
    [self.navigationController pushViewController:heightCtl animated:YES];
    

}
- (IBAction)back_home:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)manClick:(id)sender {
    HeightViewController *heightCtl=[[HeightViewController alloc]initWithNibName:@"HeightViewController" bundle:nil];
    heightCtl.isman = YES;
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    [userdefault setObject:@"0" forKey:@"sender"];
    [userdefault synchronize];
    [self.navigationController pushViewController:heightCtl animated:YES];
}
@end
