//
//  mainViewController.m
//  Ebei
//
//  Created by 李玉坤 on 15/9/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "mainViewController.h"
#import "moreViewController.h"
#import "dataViewController.h"
#import "macro.h"
#import "ConnectionViewController.h"
#import "SetDataViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "NSDate+Expend.h"
#import "wtalert.h"
#import "person.h"
#import "FMDatabaseAdditions.h"
#import "dataSimple.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"


#import "BlueTool.h"
#import "BlueWriteTool.h"

#import "person.h"

@interface mainViewController ()
{
    
    __weak IBOutlet UIImageView *upImage;
    __weak IBOutlet UILabel *shanglaLabel;
    __weak IBOutlet UILabel *footNum;
    __weak IBOutlet UIImageView *backImage;
    __weak IBOutlet UILabel *tadayNum;
    __weak IBOutlet UIButton *rightBtn;
    __weak IBOutlet UIButton *leftBtn;
    __weak IBOutlet UIView *downView;
     __block NSString *eqNumber_;
    int zongbushu;
    int shijian;
    int jiuzuoshijian;
     NSInteger shijiancuo;
    UIView *jzView;
    UILabel *jiuzuoLabel;
    MDRadialProgressView *radialView; //主页面目标完成progress描述
    UIImageView *updaraImageView;
    
    
    
    
    
    
    
    //当天的数据模型
    NSMutableArray *_currentModel;
    
    __weak IBOutlet UILabel *activityProportion;  //活动比例
    __weak IBOutlet UILabel *sitStill;            //静坐
    __weak IBOutlet UIView *activeColor;
    
    
    
    
    
    
    CGPoint _starPoint;  //记录开始结束点
    CGPoint _endPoint;
    
}
@property (weak, nonatomic) IBOutlet UILabel *huodongHourLable;
@property (weak, nonatomic) IBOutlet UILabel *jingzuoHourLable;

@end

@implementation mainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"goal"]) {
        _myGoalNum.text=[NSString stringWithFormat:@"目标%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"goal"]];
    }else{
        //存储用户信息
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"5000" forKey:@"goal"];//用户目标
        
        [userDefaults synchronize];
        
    }
   
//    [self statisticalDataPedometer];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f",_jiuzuoView.frame.size.height);
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"genxinshijian"]) {
        _gengxinshijian.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"genxinshijian"];

    }
    
    
    
    
    [self loadJiuzuoView];
    _quanImageView.frame=CGRectMake(34, 123, kScreenWidth-68, kScreenWidth-68);
    
    updaraImageView=[[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-68)/2-30, (kScreenWidth-68)/2-30, 60, 60)];
    updaraImageView.image=[UIImage imageNamed:@"升级完成.png"];
    [_quanImageView addSubview:updaraImageView];
    updaraImageView.hidden=YES;

    
    
    backImage.frame=CGRectMake((kScreenWidth-68)/2-31,(kScreenWidth-68)/2-70, 62, 18);
    [_quanImageView addSubview:backImage];

    
    footNum.frame=CGRectMake(0,(kScreenWidth-68)/2-70, (kScreenWidth-68), 20);
     footNum.textAlignment=NSTextAlignmentCenter;
    [_quanImageView addSubview:footNum];
    
    
    _myGoalNum.frame=CGRectMake(0,(kScreenWidth-68)/2+50, (kScreenWidth-68), 20);
     _myGoalNum.textAlignment=NSTextAlignmentCenter;
    [_quanImageView addSubview:_myGoalNum];

    
    _jinribushu.frame=CGRectMake(0,(kScreenWidth-68)/2-40, (kScreenWidth-68), 80);
    _jinribushu.textAlignment=NSTextAlignmentCenter;
    [_quanImageView addSubview:_jinribushu];
    
    
    
    
    
    
    
    
    
    //主页面目标完成progress描述
    radialView = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-68, kScreenWidth-68)];
    
    
    radialView.progressTotal = 60;  //圆分的格数
    radialView.progressCounter = 3; //有几个是白色的个子数   （跑得步数/目标步数）*圆分的总个数
    radialView.startingSlice = 1;   //初始显示位置
    radialView.theme.sliceDividerHidden = NO;
    radialView.theme.sliceDividerThickness = 1;
    
    // theme update works both changing the theme or the theme attributes
    radialView.theme.labelColor = [UIColor clearColor];
    radialView.theme.labelShadowColor = [UIColor clearColor];
    
    [_quanImageView addSubview:radialView ];
    
    
    
    
    
    if (kScreenHeight==480) {
        downView.frame=CGRectMake(0, kScreenHeight-45, kScreenWidth, 45);
        
    }else if (kScreenHeight==667){
         downView.frame=CGRectMake(-20, kScreenHeight-55, kScreenWidth, 55);
        
    }else if (kScreenHeight==736){
        downView.frame=CGRectMake(-30, kScreenHeight-90, kScreenWidth-30, 60);
        
    }
    
    
    
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    self.shijian.text=[NSString stringWithFormat:@"%d月%d日",(int)[dateComponent month],(int)[dateComponent day]];


    zongbushu=0;
    NSString *today = [[NSDate date] pubGetYearAndMonthAndDay];
    [self shujvku:today];
    self.navigationController.navigationBarHidden = YES;
    UISwipeGestureRecognizer *recognizer;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%f", a]; //转为字符型
    shijiancuo=[timeString intValue];

    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFromDown:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [_low_view addGestureRecognizer:recognizer];

    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFromUp:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:recognizer];
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    
    [self.view bringSubviewToFront:rightBtn];
    [self.view bringSubviewToFront:leftBtn];
    
    
       
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blueToolPedometer:) name:@"BlueToolPedometer" object:nil];
//    [self loadjiuzuoLabelView];
    
    
    
    
    //开启蓝牙扫描
    [[BlueTool sharedBlueTool] startScan];
}
//久坐时段视图 柱形图
-(void)loadJiuzuoView{
    
    
    if (kScreenHeight==480) {
        jzView=[[UIView alloc] initWithFrame:CGRectMake(32, 150, self.view.frame.size.width-64,100)];
        jzView.backgroundColor=[UIColor clearColor];
        [_jiuzuoView addSubview:jzView];

    }else if (kScreenHeight==568){
        jzView=[[UIView alloc] initWithFrame:CGRectMake(32, 200, self.view.frame.size.width-64,154)];
        jzView.backgroundColor=[UIColor clearColor];
        [_jiuzuoView addSubview:jzView];

    }else{
        jzView=[[UIView alloc] initWithFrame:CGRectMake(32, 250, self.view.frame.size.width-64,190)];
        jzView.backgroundColor=[UIColor clearColor];
        [_jiuzuoView addSubview:jzView];

    }
    
    
    
   
    
}
// 根据数据画 柱形图
-(void)loadjiuzuoLabelView:(NSArray *)jiuzuoArr time:(NSArray *)dianArr{
    
//    NSArray *jiuzuoArr=@[@"3",@"2",@"2"];
//    NSArray *dianArr=@[@"6",@"12",@"18"];
    
    
    for (int i=0; i<jiuzuoArr.count; i++) {
        float a=[jiuzuoArr[i] floatValue]*(jzView.frame.size.width)/15;
        
        float b=([dianArr[i]floatValue]-6)*(jzView.frame.size.width)/15;
        
        if (kScreenHeight==480) {
            jiuzuoLabel=[[UILabel alloc] initWithFrame:CGRectMake(b+1, 14, a, 100)];

            
        }else if (kScreenHeight==568){
            jiuzuoLabel=[[UILabel alloc] initWithFrame:CGRectMake(b+1, 14, a, 140)];

            
        }else{
            jiuzuoLabel=[[UILabel alloc] initWithFrame:CGRectMake(b+1, 12, a, 190)];

            
        }

        jiuzuoLabel.backgroundColor=[UIColor colorWithRed:54.0/255.0 green:159.0/255.0 blue:246.0/255.0 alpha:1.0];
        [jzView addSubview:jiuzuoLabel];
    }
    
    
    
}


- (void)handleSwipeFromDown:(UIGestureRecognizer *)tap{
    downView.hidden=NO;
    [UIView animateWithDuration:.4 animations:^{
   
    _low_view.frame = CGRectMake(0, 0, kScreenWidth, _low_view.frame.size.height);
    
    }];
    
}
- (void)handleSwipeFromUp:(UIGestureRecognizer *)tap{
    [UIView animateWithDuration:.4 animations:^{

        
        _low_view.frame = CGRectMake(0, kScreenHeight-_low_view.frame.size.height, kScreenWidth, _low_view.frame.size.height);
//        _low_view.frame = CGRectMake(0, 0, kScreenWidth, _low_view.frame.size.height);

    }];
    downView.hidden=YES;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)push_left:(id)sender {
    moreViewController *more = [[moreViewController alloc]initWithNibName:@"moreViewController" bundle:nil];
    [self.navigationController pushViewController:more animated:YES];
}
- (IBAction)push_right:(id)sender {
    dataViewController *data = [[dataViewController alloc]initWithNibName:@"dataViewController" bundle:nil];
    [self.navigationController pushViewController:data animated:YES];
}
                    //person *onePerson = [[person alloc]init];
           // onePerson.time = [obj[@"sportTime"] substringFromIndex:8],
          //  onePerson.bushu = obj[@"sportStep"];
          //  onePerson.day= [obj[@"sportTime"] substringToIndex:8],
          //  onePerson.myID=obj[@"sportTime"],
         //   NSLog(@"%@-%@-%@",onePerson.day,onePerson.bushu,onePerson.time);
            //写入数据库
         //   [self savePersonWith:onePerson];


          //  person *onePerson = [[person alloc]init];
          //  onePerson.time = [obj[@"sportTime"] substringFromIndex:8],
          //  onePerson.bushu = obj[@"sportStep"];
         //   onePerson.day= [obj[@"sportTime"] substringToIndex:8],
         //   onePerson.myID=obj[@"sportTime"],
         //   NSLog(@"%@-%@-%@",onePerson.day,onePerson.bushu,onePerson.time);
            //写入数据库
          //  [self savePersonWith:onePerson];






- (void)savePersonWith:(person *)onePerson{
    NSString *address = [[[dataSimple sharedDataBase] database] stringForQuery:@"SELECT bushu FROM go WHERE myID = ?",onePerson.myID];
    NSLog(@"%@",onePerson.myID);
    
    if (address==nil) {
        [[[dataSimple sharedDataBase] database] executeUpdate:@"INSERT INTO go(time,day,bushu,myID) VALUES (?,?,?,?)",onePerson.time,onePerson.day,onePerson.bushu,onePerson.myID];
        
    }
    else{
        [[[dataSimple sharedDataBase] database] executeUpdate:@"UPDATE go SET bushu=? WHERE myID = ?",onePerson.bushu,onePerson.myID];
        
    }
    [self shujvku:[[NSDate date] pubGetYearAndMonthAndDay]];
    
}
-(void)shujvku :(NSString *)today{
    
    
    _currentModel = [NSMutableArray array];
    
    
    
 //   FMResultSet *rs= [[[dataSimple sharedDataBase] database] executeQuery:@"SELECT  time, sum(bushu) FROM go WHERE day = ? group by time",today];

     FMResultSet *rs= [[[dataSimple sharedDataBase] database] executeQuery:@"select * from go WHERE day = ?",today];
    NSLog(@"%@",today);
    zongbushu=0;
    jiuzuoshijian=0;
    shijian=0;
     while ([rs next]) {//遍历所有的rs集合元素
        
        NSString *st= [rs stringForColumn:@"bushu"];
         if ([st intValue]<60000) {
              zongbushu=zongbushu+[st intValue];
             shijian=shijian+1;
         }
         else{
             jiuzuoshijian=jiuzuoshijian+1;
         }
        
        NSLog(@"%@",st);
        
         NSString *st2= [rs stringForColumn:@"time"];

        NSLog(@"%@",st2);
         NSString *st3= [rs stringForColumn:@"day"];
         
         NSLog(@"%@",st3);
         NSString *st4= [rs stringForColumn:@"myID"];
         
         NSLog(@"%@",st4);

         
         
         
         person *pers = [[person alloc] init];
         pers.bushu = st;
         pers.time = st2;
         pers.day = st3;
         pers.myID = st4;
         [_currentModel addObject:pers];
         

        }
    
    
    //
    [jzView removeFromSuperview];
    if (_currentModel.count)  {
        [self statisticalDataPedometer];
    }
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"goal"] ) {
        radialView.progressCounter = 60*zongbushu/[[[NSUserDefaults standardUserDefaults] valueForKey:@"goal"] intValue];

    }else{
        
    }
    
    NSLog(@"%d",radialView.progressCounter);
    self.jinribushu.text=[NSString stringWithFormat:@"%d",zongbushu];
//    self.huodongshijian.text=[NSString stringWithFormat:@"%d:%d",shijian/2,shijian%2*30];
    self.huodongshijian.text=[NSString stringWithFormat:@"%.1f",shijian * 30 / 60.0f];
    
    
    
//    卡路里（kcal）＝体重（kg）×距离（公里）×0.636
//    距离（米） = 身高（cm） × 步数 ×0.0036
 
    NSString *height = [[NSUserDefaults standardUserDefaults] objectForKey:@"height"];  //米
    NSString *weight = [[NSUserDefaults standardUserDefaults] objectForKey:@"weight"];  //千克
    if (height == nil) {
        height = @"1.7";
    }
    
    if (weight == nil) {
        weight = @"60";
    }
    
    CGFloat juli = [height floatValue] * zongbushu * 0.0036;
    _licheng.text = [NSString stringWithFormat:@"%.2f",juli];
    _kaluli.text = [NSString stringWithFormat:@"%.2f",[weight floatValue] * juli * 0.636];
    
}


#pragma mark- 统计计步数据

-(void)statisticalDataPedometer{
    
    int countActivity = 0;   //活动个数
    int countSit = 0;        //久坐个数
    

    NSMutableArray *indexs = [NSMutableArray array];
    
    for (int i = 0; i < _currentModel.count - 1; i++){
    
        person *per = _currentModel[i];
        person *per1 = _currentModel[i + 1];
        
        //if ([per.bushu intValue] == 65535 || [per.bushu intValue] == 0) {
            
            if ([per.bushu intValue] != [per1.bushu intValue]) {
                [indexs addObject:@(i)];
            }
            
       // }
        
        
        
        
//        if ([per.bushu intValue] != 65535 && [per.bushu intValue] == 0) {
//            countSit++;
//        }
//        
//        if (([per.bushu intValue] != 65535 && [per.bushu intValue] != 0)) {
//            countActivity++;
//        }
        
    }
    
    
    CGFloat sitTime = 0.0f;
    CGFloat activityTime = 0.0f;
    
    if (indexs.count) {
        
        for (int i = 0 ; i < indexs.count - 1 ; i++) {
            
            person *per = _currentModel[[indexs[i] intValue]];
            if ([per.bushu intValue] != 65535 && [per.bushu intValue] == 0 && ([indexs[i + 1] intValue] - [indexs[i] intValue]) > 3) {
                countSit++;
                sitTime += 0.5 * ([indexs[i + 1] intValue] - [indexs[i] intValue]);
            }
    
            if (([per.bushu intValue] != 65535 && [per.bushu intValue] != 0)) {
                countActivity++;
                activityTime += 0.5 * ([indexs[i + 1] intValue] - [indexs[i] intValue]);
            }
        }
    }
    
    
    
    
    
    
//    NSString *sss  = [NSString stringWithFormat:@"%.1f",(countSit * 100.0f) / _currentModel.count];
    
    
    
//    CGFloat allTime = (countSit + countActivity) * 0.5;
    CGFloat allTime = sitTime + activityTime;
    
//    activityProportion.text = [NSString stringWithFormat:@"%.1f",(countActivity * 50.0f) / allTime];
//    sitStill.text = [NSString stringWithFormat:@"%.1f",(countSit * 50.0f) / allTime];
    
    activityProportion.text = [NSString stringWithFormat:@"%.1f",(activityTime * 100) / allTime];
    sitStill.text = [NSString stringWithFormat:@"%.1f",(sitTime * 100) / allTime];
    
   NSLog(@"%@",activityProportion.text);
    
    CGFloat bili = 0;
    
    if (allTime == 0) {
        
    }else{
    
        bili =  300 / allTime;
        CGRect frame =  activeColor.frame;
        frame.size.width = bili * countActivity * 0.5;
        activeColor.frame = frame;
    }
    
   
    
    
    
    
    _huodongHourLable.text = [NSString stringWithFormat:@"%.1fh",countActivity * 0.5];
    _jingzuoHourLable.text = [NSString stringWithFormat:@"%.1fh",countSit * 0.5];
    
    
    
    if (indexs.count) {
        for (int i = 0; i < indexs.count - 1; i++) {
            
            
            int index = [indexs[i] intValue];
            
            if (indexs.count >= 2) {
                int index1 = [indexs[i + 1] intValue];
                
                if ((index1 - index) <= 3) {     //如果两次变化在3 以内
                    person *per = _currentModel[index];
                    per.bushu = @"0";
                    [_currentModel removeObjectAtIndex:index];
                    [_currentModel insertObject:per atIndex:index];
                }
            }else{
                
//                person *per = _currentModel[index];
//                per.bushu = @"0";
//                [_currentModel removeObjectAtIndex:index];
//                [_currentModel insertObject:per atIndex:index];
                
            }
        }

    }else{
    
        return;
    }
    
    
    
    
    
    
    
    
    
    //久坐时长
    //活动时长
    //6 到 21点
    
    indexs = [NSMutableArray array];
    
    NSMutableArray *starTimes = [NSMutableArray array];  //开始时间和时长
    NSMutableArray *longTime = [NSMutableArray array];
    
    
    
    for (int i = 0; i < _currentModel.count - 1; i++){
        
        if (i >= 11 && i <= 41){
        
            person *per = _currentModel[i];
            person *per1 = _currentModel[i + 1];
            
            if (([per.bushu intValue] != 65535) && ([per.bushu intValue] == 0)) {
            
                if ([per.bushu intValue] != [per1.bushu intValue]) {
                    [indexs addObject:@(i)];
                }
                
            }
        }
    }
    
    if (indexs.count >0) {
        if (indexs.count == 1) {
            [starTimes addObject:[NSString stringWithFormat:@"%.1f",[indexs[0] intValue] * 0.5]];
            [longTime addObject:@"0.5"];
        }else{
            NSLog(@"%d",indexs.count);
            for (int i = 0; i < indexs.count - 1; i++) {
                int index = [indexs[i] intValue];
                int index1 = [indexs[i + 1] intValue];
                
                if ((index1 - index) >= 3) {
                    [starTimes addObject:[NSString stringWithFormat:@"%.1f",index * 0.5]];
                    [longTime addObject:[NSString stringWithFormat:@"%.1f",(index1 - index) * 0.5]];
                }
                
                
            }
        }

    }else{
        return;
    }
    
    
    

    
    
    //重新绘图
    [jzView removeFromSuperview];
    [self loadJiuzuoView];
    [self loadjiuzuoLabelView:longTime time:starTimes];
}





#pragma mark - 同步历史蓝牙数据
-(void)blueToolPedometer:(NSNotification *)noti{

    NSDictionary *info = noti.userInfo;
    
    NSDate *date = info[@"date"];
    NSData *_responseData = info[@"_responseData"];
    
    
    NSDateFormatter *dateFrom = [[NSDateFormatter alloc] init];
    dateFrom.dateFormat = @"yyyyMMdd";
    NSString *dateStr = [dateFrom stringFromDate:date];
    
    
    NSUInteger _responseDataLength = _responseData.length;

    for (int i = 0; i < _responseData.length; i++) {

        int loca = i * 2;

        NSRange range = NSMakeRange(loca, 2);

        if (loca >= _responseDataLength) {  //越界了
            continue;
        }else if(loca + 2 >= _responseDataLength){
            range = NSMakeRange(loca, 1);
        }


        NSData *subData = [_responseData subdataWithRange:range];

        NSUInteger length = subData.length;
        unsigned char *subBytes = malloc(length);
        [subData getBytes:subBytes];

        int numberTwoBytes = (subBytes[0] << 8) + subBytes[1];
        int time = (i + 1) * 30;
        NSString *timeStr = [NSString stringWithFormat:@"%02d%02d",(time/60)%24,time%60];

        NSLog(@"numberTwoBytes  =  %d   count = %d     time = %@",numberTwoBytes,(i + 1),timeStr);
        
        
        
        
        person *onePerson = [[person alloc]init];
        onePerson.time = timeStr;
        onePerson.bushu = [NSString stringWithFormat:@"%d",numberTwoBytes];
        onePerson.day = dateStr;
        onePerson.myID = [NSString stringWithFormat:@"%@%@",dateStr,timeStr];
        
        [self savePersonWith:onePerson];
        
    }

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


- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"尼玛的zuo,");
        
        
//        [[wtalert sharedInstance]jinggao:@"绑定设备中，请稍等"];
        
        
//        mainViewController *setDataCtl=[[mainViewController alloc]initWithNibName:@"mainViewController" bundle:nil];
//        [self.navigationController pushViewController:setDataCtl animated:YES];
        
     
        
        
        
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
        NSString *timeString = [NSString stringWithFormat:@"%f", a]; //转为字符型
        if ([timeString floatValue]-shijiancuo<24*60*60) {

            
                if ([BlueTool sharedBlueTool].pre) {
//                    [[wtalert sharedInstance]jinggao:@"正在同步数据 请稍等"];
                    //蓝牙开启扫描
                    [[BlueTool sharedBlueTool] startScan];
                    
                    //开始扫描后延迟
                    [self performSelector:@selector(afterDelay) withObject:nil afterDelay:5];
                    

                    //获取设备号码  同步历史数据
                    NSData *data = [BlueWriteTool blueWriteTool:[NSDate date]];
                    [[BlueTool sharedBlueTool] characteristicUUID:@"000034E1-0000-1000-8000-00805F9B34FB" data:data type:2];
                       [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"uuid"];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ISMAINUPDATA"];
                    radialView.progressCounter = 45;
                    
                }
            NSDateFormatter *dateForm = [self dateFormatter];
            dateForm.dateFormat = @"hh:mm更新";
           _gengxinshijian.text = [dateForm stringFromDate:[NSDate date]];
            
            [[NSUserDefaults standardUserDefaults] setObject:_gengxinshijian.text forKey:@"genxinshijian"];
            
            
            
            _quanImageView.frame=CGRectMake(34, 123, kScreenWidth-68, kScreenWidth-68);
            downView.hidden=YES;
            backImage.hidden=YES;
            footNum.hidden=YES;
            _myGoalNum.hidden=YES;
            _jinribushu.hidden=YES;
            self.shijian.text=@"更新数据中....";
            updaraImageView.hidden=NO;
            upImage.hidden=YES;
            shanglaLabel.hidden=YES;
           
            
            [self performSelector:@selector(afterTimer) withObject:nil afterDelay:3];
            
            
            return;
        }else{
            //滑动动画
            [UIView animateWithDuration:0.5
                             animations:^{
                                 _quanImageView.frame=CGRectMake(-kScreenWidth, 123, kScreenWidth-68, kScreenWidth-68);
                 } completion:^(BOOL finished) {
                     
                     if ([[NSUserDefaults standardUserDefaults] valueForKey:@"goal"] ) {
                         radialView.progressCounter = 60*zongbushu/[[[NSUserDefaults standardUserDefaults] valueForKey:@"goal"] intValue];
                         
                     }else{
                         
                     }
                     
                     
                        _quanImageView.frame=CGRectMake(34, 123, kScreenWidth-68, kScreenWidth-68);
                }];

        }
        NSString *nowtime=[NSString stringWithFormat:@"%d",(int)(shijiancuo+24*60*60)];
        
        shijiancuo=shijiancuo+24*60*60;
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyyMMddHHMM"];
        NSInteger lsecs=[nowtime integerValue];
        NSDate *adate = [NSDate dateWithTimeIntervalSince1970:lsecs];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:adate];
        self.shijian.text=[NSString stringWithFormat:@"%d月%d日",(int)[dateComponent month],(int)[dateComponent day]];
        NSString *today = [NSString stringWithFormat:@"%02d%02d%02d",(int)[dateComponent year],(int)[dateComponent month],(int)[dateComponent day]];
        [self shujvku:today];

        
        

    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
       
         NSLog(@"尼玛的you,");
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
        NSString *timeString = [NSString stringWithFormat:@"%f", a]; //转为字符型
        NSString *nowtime=[NSString stringWithFormat:@"%d",(int)shijiancuo-24*60*60];
        shijiancuo=shijiancuo-24*60*60;
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyyMMddHHMM"];
        NSInteger lsecs=[nowtime integerValue];
        NSDate *adate = [NSDate dateWithTimeIntervalSince1970:lsecs];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:adate];
        self.shijian.text=[NSString stringWithFormat:@"%d月%d日",(int)[dateComponent month],(int)[dateComponent day]];
        
        NSString *today = [NSString stringWithFormat:@"%d%02d%02d",(int)[dateComponent year],(int)[dateComponent month],(int)[dateComponent day]];
        //滑动动画
        [UIView animateWithDuration:0.5
                         animations:^{
                             radialView.progressCounter = 3;
                             _quanImageView.frame=CGRectMake(kScreenWidth, 123, kScreenWidth-68, kScreenWidth-68);
                         } completion:^(BOOL finished) {
                            [self shujvku:today];
                             _quanImageView.frame=CGRectMake(34, 123, kScreenWidth-68, kScreenWidth-68);
                         }];
      



        
    }
}
-(void)afterTimer{
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ISMAINUPDATA"]==NO) {
        
        
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"goal"] ) {
            radialView.progressCounter = 60*zongbushu/[[[NSUserDefaults standardUserDefaults] valueForKey:@"goal"] intValue];
            
        }else{
            
        }

        _quanImageView.frame=CGRectMake(34, 123, kScreenWidth-68, kScreenWidth-68);
        
        downView.hidden=NO;
        updaraImageView.hidden=YES;
        backImage.hidden=NO;
        footNum.hidden=NO;
        _myGoalNum.hidden=NO;
        _jinribushu.hidden=NO;
        upImage.hidden=NO;
        shanglaLabel.hidden=NO;

        NSDateFormatter *dateForm = [self dateFormatter];
        dateForm.dateFormat = @"MM月dd日";
        self.shijian.text = [dateForm stringFromDate:[NSDate date]];
        
      
    }else{
        
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"goal"] ) {
            radialView.progressCounter = 60*zongbushu/[[[NSUserDefaults standardUserDefaults] valueForKey:@"goal"] intValue];
            
        }else{
            
        }

        
        _quanImageView.frame=CGRectMake(34, 123, kScreenWidth-68, kScreenWidth-68);
        
        downView.hidden=NO;
        updaraImageView.hidden=YES;
        backImage.hidden=NO;
        footNum.hidden=NO;
        _myGoalNum.hidden=NO;
        _jinribushu.hidden=NO;
        upImage.hidden=NO;
        shanglaLabel.hidden=NO;

        NSDateFormatter *dateForm = [self dateFormatter];
        dateForm.dateFormat = @"MM月dd日";
        self.shijian.text = [dateForm stringFromDate:[NSDate date]];
        

    }
}


//日期格式化工具
- (NSDateFormatter *)dateFormatter{
    
    NSDateFormatter *dateFormatter;
    dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"MM月dd日";
    
    return dateFormatter;
}
@end
