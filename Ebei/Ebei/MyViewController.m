//
//  MyViewController.m
//  Ebei
//
//  Created by 金瑞德科技 on 15-9-11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MyViewController.h"
#import "AboutViewController.h"
#import "FeedbackViewController.h"
#import "GoalViewController.h"
#import "HeightViewController.h"
#import "heavyViewController.h"
#import "yaoweiViewController.h"
#import "LoginViewController.h"



#import "BlueWriteTool.h"
#import "BlueTool.h"
#import "NETWork.h"
#import "HUDHelper.h"


#define IsHeight       ([UIScreen mainScreen].bounds.size.height==480.0 ? 6 :0)

@interface MyViewController ()<UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    __weak IBOutlet UIButton *myHeight;
    __weak IBOutlet UIButton *myHeavy;
    
    __weak IBOutlet UIButton *yaoWei;
    __weak IBOutlet UITableView *myTableView;
    __weak IBOutlet UIButton *headImgView;
    UISwitch *_open;

    NSArray *arr;
    NSString *goalStr;
    UILabel *label1;
}
- (IBAction)headImgViewClick:(id)sender;
- (IBAction)setMyheight:(id)sender;
- (IBAction)setHeavy:(id)sender;
- (IBAction)setMyYao:(id)sender;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
       self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:243/255.0 blue:247/255.0 alpha:1];

    headImgView.layer.cornerRadius=40;
    
    NSArray *sec=@[@[[UIImage imageNamed:@"目标.png"],@"目标",[UIImage imageNamed:@"进入.png"]],@[[UIImage imageNamed:@"久坐推送提醒.png"],@"久坐推送提醒",[UIImage imageNamed:@"进入.png"]]];
    NSArray *sec1=@[@[[UIImage imageNamed:@"关于.png"],@"关于",[UIImage imageNamed:@"进入.png"]],@[[UIImage imageNamed:@"反馈.png"],@"反馈",[UIImage imageNamed:@"进入.png"]]];
    arr=@[sec,sec1];
    

    //.添加退出按钮到tableView的最底部
    UIButton *btnExit1 = [[UIButton alloc] init];
    btnExit1.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 40);
    btnExit1.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnExit1 addTarget:self action:@selector(exitClick) forControlEvents:UIControlEventTouchUpInside];
   
    // 设置背景
    btnExit1.backgroundColor = [UIColor colorWithRed:54.0/255 green:160.0/255 blue:247.0/255 alpha:1];
    [btnExit1 setTitle:@"退出登录" forState:UIControlStateNormal];
    [btnExit1 addTarget:self action:@selector(outBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0 , 70)];
    [footer addSubview:btnExit1];
    
    // footerView的宽度固定是320
    myTableView.tableFooterView = footer;
   

    myTableView.scrollEnabled=NO;
    myTableView.backgroundColor=[UIColor clearColor];
    
    
}
-(void)outBtnClick{
    
    
    [NETWork  request:@"http://112.74.27.169:8001/ebelt/user/logout?scode=kSV98quY5i1LAJqLIzbbVJXC4xSUCIx0" Success:^(NSDictionary *mdoel) {
        
         NSLog(@"=-=%@",mdoel);
        
        if ([[mdoel objectForKey:@"msg"] isEqualToString:@"Need relogin"]) {
            NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
            
            [userDefault removeObjectForKey:@"phone"];
            [userDefault removeObjectForKey:@"pwd"];
            
            
             [HUDHelper showMessag:@"登出成功"];
            LoginViewController *loginCtl=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginCtl animated:YES];
        }else{
            
        }
        
    } failed:^(NSError *error) {
        
    }];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"=-=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"height"]);
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"height"]) {
        
        [myHeight setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"height"] forState:normal];
    }else{
        [myHeight setTitle:@"178" forState:normal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"weight"]) {
        [myHeavy setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"weight"] forState:normal];
    }else{
        
    }

    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"rule"]) {
        
        [yaoWei setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"rule"] forState:normal];
    }else{
        [myHeight setTitle:@"3.0" forState:normal];
    }
    
    
    
    if ([[NSUserDefaults  standardUserDefaults] valueForKey:@"goal"]) {
        label1.text=[[NSUserDefaults  standardUserDefaults] valueForKey:@"goal"];
        goalStr=[[NSUserDefaults  standardUserDefaults] valueForKey:@"goal"];
    }else{
    }

}
-(void)viewDidAppear:(BOOL)animated{
    
    
    
    [super viewDidAppear:animated];
        self.navigationController.navigationBarHidden = NO;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

}
#pragma mark 确定
- (void)exitClick
{
    
}
#pragma mark--
#pragma mark tableview代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return arr.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return ((NSArray *)arr[section]).count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        return 40;
    }
    return 52;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) { // 创建cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        NSArray *array=arr[indexPath.section][indexPath.row];
        NSLog(@"---%@",array[0]);
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 18-IsHeight, 15, 15)];
        imgView.image=array[0];
        [cell addSubview:imgView];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 11-IsHeight, 90, 30)];
        label.font=[UIFont fontWithName:nil size:15];
        label.text=array[1];
        [cell addSubview:label];
        
        UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-25, 20-IsHeight, 8, 12)];
        imgView1.image=array[2];
        [cell addSubview:imgView1];
        
        
        if (array==arr[0][0]) {
            UILabel *labe=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40, 17-IsHeight, 10, 22)];
            labe.font=[UIFont fontWithName:nil size:9];
            labe.textColor=[UIColor lightGrayColor];
            labe.text=@"步";
            [cell addSubview:labe];
            
           label1=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-95, 15-IsHeight, 55, 22)];
            label1.font=[UIFont fontWithName:nil size:16];
            label1.textAlignment=NSTextAlignmentRight;
            label1.textColor=[UIColor lightGrayColor];
            if ([[NSUserDefaults  standardUserDefaults] valueForKey:@"goal"]) {
              label1.text=goalStr;
            }else{
                 label1.text=@"10000";
            }
            
            
            [cell addSubview:label1];
        }
        if (array==arr[0][1]) {
            
            imgView1.hidden = YES;
            
            UISwitch *open = [[UISwitch alloc] init];
            open.center = CGPointMake(self.view.frame.size.width - 40, 25-IsHeight);
            BOOL isOpen = [[NSUserDefaults standardUserDefaults] boolForKey:@"picStingIsOpen"];
         
//            if (isOpen) {
//                open.backgroundColor=[UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
//            }else{
//                open.backgroundColor=[UIColor colorWithRed:54/255.0 green:  160/255.0 blue:247/255.0 alpha:1];
//
//            }
            open.on = !isOpen;
            [open addTarget:self action:@selector(isOpen:) forControlEvents:UIControlEventValueChanged];
            
            [cell.contentView addSubview:open];
            _open = open;

            
        }
        
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0&&indexPath.row==0) {
        
        
        [self.navigationController pushViewController:[[GoalViewController alloc] init] animated:YES];
    }
    
    
    
    if (indexPath.section==1&&indexPath.row==0) {
        AboutViewController *aboutCtl=[[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
        [self.navigationController pushViewController:aboutCtl animated:YES];
    }
    

    if (indexPath.section==1&&indexPath.row==1) {
        FeedbackViewController *feedbackCtl=[[FeedbackViewController alloc]initWithNibName:@"FeedbackViewController" bundle:nil];
        [self.navigationController pushViewController:feedbackCtl animated:YES];

    }
    
}
-(void)isOpen:(UISwitch *)swc{
    
    
    //写入久坐提醒时间
    
//    BOOL  ss = swc.isOn;
    
    NSData *data = [BlueWriteTool blueWriteToolsedentaryReminder:swc.isOn timeInterval:@"01:00" starTime:@"08:00" endTime:@"23:59"];
    [[BlueTool sharedBlueTool] characteristicUUID:@"000034E1-0000-1000-8000-00805F9B34FB" data:data type:2];
    
     [[NSUserDefaults standardUserDefaults] setBool:!swc.isOn forKey:@"picStingIsOpen"];
    
}

- (IBAction)headImgViewClick:(id)sender {
    
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从照片中选择", nil];
    sheet.delegate =self;
    sheet.tag=2;
    [sheet showInView:self.view];

}




-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==2) {
        switch (buttonIndex) {
            case 0:
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    
                    // 1. 实例化照片选择控制器
                    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
                    [picker setAllowsEditing:YES];
                    [picker setDelegate:self];
                    
                    // 3. 显示选择控制器
                    [self presentViewController:picker animated:YES completion:nil];
                }
                NSLog(@"拍照");
                break;
                
            case 1:
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                    
                    // 1. 实例化照片选择控制器
                    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                    [picker setAllowsEditing:YES];
                    [picker setDelegate:self];
                    
                    // 3. 显示选择控制器
                    [self presentViewController:picker animated:YES completion:nil];
                }
                
                NSLog(@"从照片库中选择");
                break;
        }
        
        
    }
    
    
    
}
- (IBAction)back_home:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)setMyheight:(id)sender{
    HeightViewController *old = [[HeightViewController alloc]initWithNibName:@"HeightViewController" bundle:nil];
    [self.navigationController pushViewController:old animated:YES];
    
    
}

- (IBAction)setHeavy:(id)sender {
    heavyViewController *old = [[heavyViewController alloc]initWithNibName:@"heavyViewController" bundle:nil];
    [self.navigationController pushViewController:old animated:YES];
}

- (IBAction)setMyYao:(id)sender {
    yaoweiViewController *old = [[yaoweiViewController alloc]initWithNibName:@"yaoweiViewController" bundle:nil];
    [self.navigationController pushViewController:old animated:YES];
    
   }


@end
