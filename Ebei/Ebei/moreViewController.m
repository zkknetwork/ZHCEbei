//
//  moreViewController.m
//  Ebei
//
//  Created by 李玉坤 on 15/9/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "moreViewController.h"
#import "MyViewController.h"
#import "myyaodaiViewController.h"
#import "shareViewController.h"
#import "ConnectionViewController.h"
@interface moreViewController ()

- (IBAction)myClick:(id)sender;
@end

@implementation moreViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

}
- (IBAction)back_home:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)myClick:(id)sender {
    MyViewController *myCtl=[[MyViewController alloc]initWithNibName:@"MyViewController" bundle:nil];
    [self.navigationController pushViewController:myCtl animated:YES];
}
- (IBAction)look_myyaodai:(id)sender {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastDevUUID"]!=nil) {
        
        myyaodaiViewController *yaodai = [[myyaodaiViewController alloc]initWithNibName:@"myyaodaiViewController" bundle:nil];
        [self.navigationController pushViewController:yaodai animated:YES];
    }else{
        
        ConnectionViewController *connectionCtl=[[ConnectionViewController alloc]initWithNibName:@"ConnectionViewController" bundle:nil];
        [self.navigationController pushViewController:connectionCtl animated:YES];
    }
    
}
- (IBAction)share_mydata:(id)sender {
    
    shareViewController *share = [[shareViewController alloc]initWithNibName:@"shareViewController" bundle:nil];
    [self.navigationController presentViewController:share animated:YES completion:nil];
}
@end
