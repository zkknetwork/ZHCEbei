//
//  dataViewController.m
//  Ebei
//
//  Created by 李玉坤 on 15/9/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "dataViewController.h"

#import "FMDatabaseAdditions.h"
#import "dataSimple.h"
#import "person.h"
@interface dataViewController (){
    int move;
    UIView *topView;
    
    
    
    
    
    //当天的数据模型
    NSMutableArray *_currentModel;
    
    
    int zongbushu;
    int shijian;
    int jiuzuoshijian;
    
    
    
    
    int currentModel;
    
    
    
    
    UIView *_bottomTimeView;  //底部时间view
    
    
    
    NSDate *_currentDate;  //当前日期
    
}
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *weekLable;


@property (weak, nonatomic) IBOutlet UILabel *stiTimeLable; //静坐时间
@property (weak, nonatomic) IBOutlet UILabel *stiCountLable; //静坐次数
@property (weak, nonatomic) IBOutlet UILabel *huodongshijianLable;
@property (weak, nonatomic) IBOutlet UILabel *stepLable;

@property (weak, nonatomic) IBOutlet UILabel *lichengLable;
@property (weak, nonatomic) IBOutlet UILabel *kaluli;


@end

@implementation dataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _base_view.layer.cornerRadius = 6.0;
    
    
    
//

    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];

    
    

    //设置今天日期
    

    NSDateFormatter *dateForm = [self dateFormatter];
    dateForm.dateFormat = @"MM月dd日";
    _dateLable.text = [dateForm stringFromDate:[NSDate date]];
    
    dateForm.dateFormat = @"EE";
    _weekLable.text = [dateForm stringFromDate:[NSDate date]];
    
    
    
    dateForm.dateFormat = @"yyyyMMdd";
    
    
    [UIView animateWithDuration:0.1 animations:^{
        move=10;
        //加载顶部试图
        [self loadTopView];
    } completion:^(BOOL finished) {
        [topView removeFromSuperview];
        
        
        [self loadTopView];
          [self shujvku:[dateForm stringFromDate:[NSDate date]]];
        
    }];

  
    
    
    [_bottomTimeView removeFromSuperview];
    _bottomTimeView = [self addTimeAtTheBottomOfTheTable:0];
    
}

//顶部视图
-(void)loadTopView{
    
    topView=[[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,_base_view.frame.origin.y-64)];
//    topView.backgroundColor=[UIColor redColor];
    [self.view addSubview:topView];
    
   
}

//左右滑动更新数据
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    //设置今天日期
    
    NSDateFormatter *dateForm = [self dateFormatter];
    dateForm.dateFormat = @"MM月dd日";
    NSString *dateStr =  _dateLable.text;
    NSDate *date = [dateForm dateFromString:dateStr];
    
    NSDate *now = [dateForm dateFromString:[dateForm stringFromDate:[NSDate date]]];
    
    
    
//    [self weekqueryProcessingData:nil];
    
    
    
    
    if (move==10) {
        if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
            NSLog(@"日左滑");
            date = [NSDate dateWithTimeInterval:24 * 3600 sinceDate:date];
        }
        if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
            date = [NSDate dateWithTimeInterval:-24 * 3600 sinceDate:date];
            NSLog(@"日右滑");
        }
        
        if ([date timeIntervalSince1970] <= [now timeIntervalSince1970] ) {
            
            _stiTimeLable.text = @"0";
            _stiCountLable.text = @"0";
            _huodongshijianLable.text = @"0";
            _stepLable.text = @"0";
            _lichengLable.text = @"0";
            _kaluli.text = @"0";
            
            _dateLable.text = [dateForm stringFromDate:date];
            dateForm.dateFormat = @"EE";
            _weekLable.text = [dateForm stringFromDate:date];
            
            
            dateForm.dateFormat = @"MMdd";
            NSString *chaxun = [dateForm stringFromDate:date];
            NSString *sss = [NSString stringWithFormat:@"2015%@",chaxun];
            [self shujvku:sss];
        }
    }
    if (move==11) {
        
        if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
            NSLog(@"周左滑");
            date = [NSDate dateWithTimeInterval:7 * 24 * 3600 sinceDate:date];
        }
        
        if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
            NSLog(@"周右滑");
            date = [NSDate dateWithTimeInterval:- 7 * 24 * 3600 sinceDate:date];
        }
        
        if ([date timeIntervalSince1970] <= [now timeIntervalSince1970] ) {
            
            _stiTimeLable.text = @"0";
            _stiCountLable.text = @"0";
            _huodongshijianLable.text = @"0";
            _stepLable.text = @"0";
            _lichengLable.text = @"0";
            _kaluli.text = @"0";
            
            
            dateForm.dateFormat = @"MM月dd日";
            _dateLable.text = [dateForm stringFromDate:date];
            dateForm.dateFormat = @"EE";
            _weekLable.text = [dateForm stringFromDate:date];
            
            
            [self ssssssssssssssssssweek];
        }
        
        
        
    }

    if (move==12) {
        
        
        //查询上个月有多少天
        dateForm.dateFormat = @"MM月dd日";
        NSDate *datesssssssss = [dateForm dateFromString:_dateLable.text];
        
        NSArray *starEnd = [self getWeekBeginWith:datesssssssss model:1];
        NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
        dateForm.dateFormat = @"yyyyMMdd";
        
        
        if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
            NSLog(@"周左滑");
//            date = [NSDate dateWithTimeInterval:lastMouth.count * 24 * 3600 sinceDate:date];
            NSDate *datessssss = [dateForm dateFromString:starEnd[1]];
            
            NSDate *lastMoth = [NSDate dateWithTimeInterval:24 * 3600 sinceDate:datessssss];
            
            starEnd = [self getWeekBeginWith:lastMoth model:1];
            NSArray *lastMouth = [self mouthDayArray:starEnd[0] end:starEnd[1]];
            
            date = [lastMouth firstObject];
        }
        
        if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
            NSLog(@"周右滑");
//            date = [NSDate dateWithTimeInterval:- (lastMouth.count) * 24 * 3600 sinceDate:date];
            NSDate *datessssss = [dateForm dateFromString:starEnd[0]];
            
            NSDate *lastMoth = [NSDate dateWithTimeInterval:-24 * 3600 sinceDate:datessssss];
            
            starEnd = [self getWeekBeginWith:lastMoth model:1];
            NSArray *lastMouth = [self mouthDayArray:starEnd[0] end:starEnd[1]];
            date = [lastMouth firstObject];
        }
        
        dateForm.dateFormat = @"MMdd";
        NSString *textdate = [dateForm stringFromDate:date];
        date = [dateForm dateFromString:textdate];
        
        if ([date timeIntervalSince1970] <= [now timeIntervalSince1970] ) {
            
            _stiTimeLable.text = @"0";
            _stiCountLable.text = @"0";
            _huodongshijianLable.text = @"0";
            _stepLable.text = @"0";
            _lichengLable.text = @"0";
            _kaluli.text = @"0";
            
            
            dateForm.dateFormat = @"MM月dd日";
            _dateLable.text = [dateForm stringFromDate:date];
            dateForm.dateFormat = @"EE";
            _weekLable.text = [dateForm stringFromDate:date];
            
            
            [self ssssssssssssssssssmouth];
        }
    }

 
}


- (IBAction)back_home:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)select_dateWeekMon:(id)sender {
    UIButton *but = sender;
    for(int i=10;i<13;i++){
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        button.selected = NO;
    }
    but.selected = YES;
    
    
    
//    currentModel = but.tag;
    
    
    
    
    
    if (but.tag==10) {
        
        move=10;
        NSDateFormatter *dateForm = [self dateFormatter];
        dateForm.dateFormat = @"MM月dd日";
        _dateLable.text = [dateForm stringFromDate:[NSDate date]];
        dateForm.dateFormat = @"EE";
        _weekLable.text = [dateForm stringFromDate:[NSDate date]];
        dateForm.dateFormat = @"yyyyMMdd";
        [self shujvku:[dateForm stringFromDate:[NSDate date]]];
        
        [_bottomTimeView removeFromSuperview];
        _bottomTimeView = [self addTimeAtTheBottomOfTheTable:0];
        
    }else if (but.tag==11){
        
        [self ssssssssssssssssssweek];
        
        [_bottomTimeView removeFromSuperview];
        _bottomTimeView = [self addTimeAtTheBottomOfTheTable:1];
    }else if (but.tag==12){
        
        
        [self ssssssssssssssssssmouth];
        
        [_bottomTimeView removeFromSuperview];
        _bottomTimeView = [self addTimeAtTheBottomOfTheTable:2];
     }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - 按照查询并显示数据  统计计步数据  按照天去统计

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
    
    [topView removeFromSuperview];
    if (_currentModel.count) {
        [self statisticalDataPedometer];
        [self setLableData];
        
    }
    
    
   
    
    
}


//日期格式化工具
- (NSDateFormatter *)dateFormatter{
    
     NSDateFormatter *dateFormatter;
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MM月dd日";
    
    return dateFormatter;
}







-(void)statisticalDataPedometer{
    
    int countActivity = 0;   //活动个数
    int countSit = 0;        //久坐个数
    
    
    NSMutableArray *indexs = [NSMutableArray array];
    
    
    for (int i = 0; i < _currentModel.count - 1; i++){
        
        person *per = _currentModel[i];
        person *per1 = _currentModel[i + 1];
        
//        if ([per.bushu intValue] == 65535 || [per.bushu intValue] == 0) {
        
            if ([per.bushu intValue] != [per1.bushu intValue]) {
                [indexs addObject:@(i)];
            }
            
//        }
    
        
        
        
//        if ([per.bushu intValue] == 0) {
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
            
            
            
            if (([indexs[i + 1] intValue] - [indexs[i] intValue]) >= 3) {
                if ([per.bushu intValue] != 65535 && [per.bushu intValue] == 0) {
                    countSit++;
                    sitTime += 0.5 * ([indexs[i + 1] intValue] - [indexs[i] intValue]);
                }
            }
            
            
            if (([per.bushu intValue] != 65535 && [per.bushu intValue] != 0)) {
                countActivity++;
                activityTime += 0.5 * ([indexs[i + 1] intValue] - [indexs[i] intValue]);
            }
        }
    }
    
    
    NSString *stiTimeLable = [NSString stringWithFormat:@"%.f",sitTime *  30];
    NSString *stiCountLable = [NSString stringWithFormat:@"%d",countSit];
    NSString *huodongshijianLable = [NSString stringWithFormat:@"%.1f",activityTime * 30];
    
    
    _stiTimeLable.text = stiTimeLable;
    _stiCountLable.text = stiCountLable;
    _huodongshijianLable.text = huodongshijianLable;
    
//    _stiTimeLable.text = [NSString stringWithFormat:@"%.f",countSit * 0.5 *  30];
//    _stiCountLable.text = [NSString stringWithFormat:@"%d",countSit];
//    _huodongshijianLable.text = [NSString stringWithFormat:@"%.1f",countActivity * 0.5 * 30];
    
    
    NSMutableArray *countArr = [NSMutableArray array];
    for (int i = 0; i < 48; i++) {
        [countArr addObject:@"0"];
    }
    
    for (int i = 0; i < _currentModel.count; i++){
        person *per = _currentModel[i];
        int bushu = [per.bushu intValue];
        
        if (bushu > 60000) {
            bushu = 0;
        }
        
        
        [countArr removeObjectAtIndex:i];
        [countArr insertObject:[NSString stringWithFormat:@"%d",bushu] atIndex:i];
        
    }
    
    
    [self laodTopView:countArr type:10];
    //重新绘图
}




-(void)setLableData{

//    @property (weak, nonatomic) IBOutlet UILabel *stiTimeLable; //静坐时间
//    @property (weak, nonatomic) IBOutlet UILabel *stiCountLable; //静坐次数
//    @property (weak, nonatomic) IBOutlet UILabel *huodongshijianLable;
//    @property (weak, nonatomic) IBOutlet UILabel *stepLable;
//    
//    @property (weak, nonatomic) IBOutlet UILabel *lichengLable;
//    @property (weak, nonatomic) IBOutlet UILabel *kaluli;
    
    
    
    NSString *height = [[NSUserDefaults standardUserDefaults] objectForKey:@"height"];  //米
    NSString *weight = [[NSUserDefaults standardUserDefaults] objectForKey:@"weight"];  //千克
    if (height == nil) {
        height = @"1.7";
    }
    
    if (weight == nil) {
        weight = @"60";
    }

    CGFloat juli = [height floatValue] * zongbushu * 0.0036;
    NSString *kmStr = [NSString stringWithFormat:@"%.2f",juli];
    NSString *kcaStr = [NSString stringWithFormat:@"%.2f",[weight floatValue] * juli * 0.636];
    
    _stepLable.text = [NSString stringWithFormat:@"%d",zongbushu];
    _lichengLable.text =kmStr;
    _kaluli.text = kcaStr;
    
}








#pragma mark - 刷新顶部View

-(void)laodTopView:(NSArray *)countArray type:(int) type{

  
        [topView removeFromSuperview];
        [self loadTopView];
        
    
    
    
    
        move=type;
    
    
    float max = 0;
      for (int i=0; i<countArray.count; i++) {
    
          float temp = [countArray[i] floatValue];
          
          if (i == 0) {
              max = temp;
          }else{
          
              max = (max > temp) ? max : temp;
          }
    
     }
    
    
    if (max == 0) {
        max = 10;
    }
    
    
        
        //根据数组组装  柱形图
        for (int i=0; i<countArray.count; i++) {
            
//            NSLog(@"%@",[[NSUserDefaults  standardUserDefaults] valueForKey:@"goal"]);
            
//            float h  = [[[NSUserDefaults  standardUserDefaults] valueForKey:@"goal"] floatValue];
            
            float h = max;
            
            
             float a=[countArray[i] intValue]/h;
            if (a>1) {
                
//                UILabel *datanum=[[UILabel alloc] initWithFrame:CGRectMake(10+((topView.frame.size.width-20)/countArray.count)*i,-10,40, 10)];
//                datanum.text=[NSString stringWithFormat:@"%@",countArray[i]];
//                datanum.font=[UIFont systemFontOfSize:10];
//                datanum.textColor=[UIColor whiteColor];
//                [topView addSubview:datanum];
                
                a=1;
            }else{
                a=[countArray[i] intValue]/h;
            }
           
            
            
            UILabel *dataLabel=[[UILabel alloc] initWithFrame:CGRectMake(10+((topView.frame.size.width-20)/countArray.count)*i,topView.frame.size.height-a*topView.frame.size.height,(topView.frame.size.width-20)/countArray.count, a*topView.frame.size.height)];
            dataLabel.backgroundColor=[UIColor whiteColor];
            [topView addSubview:dataLabel];
            
            
            
        }
 
}




#pragma mark - 按照星期查询处理数据   //星期和月份

-(NSArray *)weekqueryProcessingData:(int )model{

    NSDateFormatter *dateForm = [self dateFormatter];
    
    NSString *dateStr =  _dateLable.text;
    dateForm.dateFormat = @"MM月dd日";
    NSDate *datessss = [dateForm dateFromString:dateStr];
    
    dateForm.dateFormat = @"MMdd";
    NSString *chaxun = [dateForm stringFromDate:datessss];
    NSString *sss = [NSString stringWithFormat:@"2015%@",chaxun];
    
    dateForm.dateFormat = @"yyyyMMdd";
    
//    NSArray *starEnd = [self getWeekBeginWith:[dateForm dateFromString:sss] model:0];
    
    NSArray *datas = [NSArray array];
    
    if (model == 1) {
        NSArray *weeks = [self weekDayArray:[dateForm dateFromString:sss]];
        //按照星期查询数据
        NSMutableArray *weeksData = [NSMutableArray array];
        for (int i = 0; i < 7; i++) {
            [weeksData addObject:[self queryProcessingData:[dateForm stringFromDate:weeks[i]]]];
        }
        
        
        datas = weeksData;
        
    }else if (model == 2){
    
        NSArray *starEnd = [self getWeekBeginWith:[dateForm dateFromString:sss] model:1];
        NSArray *mouth = [self mouthDayArray:starEnd[0] end:starEnd[1]];
        
        //按照星期查询数据
        NSMutableArray *mouthData = [NSMutableArray array];
        for (int i = 0; i < mouth.count; i++) {
            [mouthData addObject:[self queryProcessingData:[dateForm stringFromDate:mouth[i]]]];
        }
        
        datas = mouthData;
    }
    
    
    
    return datas;
}



-(NSArray *)mouthDayArray:(NSString *)starDate end:(NSString *)endDate{

    NSMutableArray *mouth = [NSMutableArray array];
    
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    dateForm.dateFormat = @"yyyyMMdd";
    NSDate *star = [dateForm dateFromString:starDate];
    NSDate *end = [dateForm dateFromString:endDate];
    
    
    for (int i = 0; i < 31; i++) {
        NSDate *date = [NSDate dateWithTimeInterval:i * 24 * 3600 sinceDate:star];
        
        if ([date timeIntervalSince1970] <= [end timeIntervalSince1970]) {
            [mouth addObject:date];
        }
    }
    
    return mouth;
}


-(NSArray*)weekDayArray:(NSDate *)date{
    
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    for (int i = 1; i<=7; i++) {
        [componentsToAdd setDay:(i - [weekdayComponents weekday])];
        NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
        [mArray addObject:endOfWeek];
    }
    
    return [NSArray arrayWithArray:mArray];
}





#pragma mark - 根据日期查询
-(NSDictionary *)queryProcessingData:(NSString *)today{

    FMResultSet *rs= [[[dataSimple sharedDataBase] database] executeQuery:@"select * from go WHERE day = ?",today];
    NSLog(@"%@",today);
    
    
    zongbushu=0;
    jiuzuoshijian=0;
    shijian=0;
    
    
    NSMutableArray *model = [NSMutableArray array];
    
    
    while ([rs next]) {//遍历所有的rs集合元素
        
        NSString *st= [rs stringForColumn:@"bushu"];
        if ([st intValue]<60000) {
            zongbushu=zongbushu+[st intValue];
            shijian=shijian+1;
        }
        else{
            jiuzuoshijian=jiuzuoshijian+1;
        }
        
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
        [model addObject:pers];
    }
    
    

    NSMutableDictionary *bushuAndjiuzuo = [NSMutableDictionary dictionary];
    
    NSString *height = [[NSUserDefaults standardUserDefaults] objectForKey:@"height"];  //米
    NSString *weight = [[NSUserDefaults standardUserDefaults] objectForKey:@"weight"];  //千克
    if (height == nil) {
        height = @"1.7";
    }
    
    if (weight == nil) {
        weight = @"60";
    }
    
    
    
    
    
    //这个日期的 步数 距离 卡路里
    CGFloat juli = [height floatValue] * zongbushu * 0.0036;
    
    NSString *kmStr = [NSString stringWithFormat:@"%.2f",juli];
    NSString *kcaStr = [NSString stringWithFormat:@"%.2f",[weight floatValue] * juli * 0.636];
    NSString *stepStr = [NSString stringWithFormat:@"%d",zongbushu];
    
    
    [bushuAndjiuzuo setObject:kmStr forKey:@"kmStr"];
    [bushuAndjiuzuo setObject:kcaStr forKey:@"kcaStr"];
    [bushuAndjiuzuo setObject:stepStr forKey:@"stepStr"];
    [bushuAndjiuzuo setObject:today forKey:@"dateStr"];
    
    
    
    
//    return @[stiTimeLable,stiCountLable,huodongshijianLable];
    
    if (model.count) {
        NSArray *stiTimeCounthuodong = [self ssssssssss:model];
        [bushuAndjiuzuo setObject:stiTimeCounthuodong[0] forKey:@"stiTime"];
        [bushuAndjiuzuo setObject:stiTimeCounthuodong[1] forKey:@"stiCount"];
        [bushuAndjiuzuo setObject:stiTimeCounthuodong[2] forKey:@"huodongshijian"];
    }
    
    
    
    
    return bushuAndjiuzuo;
}






#pragma mark 给定一个日期 计算这个日期每周的开始  每月的结束 日期
//model  0 是周  1 是月  2 是年
-(NSArray *)getWeekBeginWith:(NSDate *)newDate model:(int)model{
    
    if (newDate == nil) {
        newDate = [NSDate date];
    }
    double interval = 0;
    NSDate *starDate = nil;
    NSDate *endDate = nil;
    
    
    NSUInteger calendarUnit = 0;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    if (model == 0) {
        calendarUnit = NSWeekCalendarUnit;
        [calendar setFirstWeekday:2];   //设定周一为周首日
    }else if (model == 1){
        calendarUnit = NSMonthCalendarUnit;
    }else{
        calendarUnit = NSYearCalendarUnit;
    }
    
    
    
    BOOL complet = [calendar rangeOfUnit:calendarUnit startDate:&starDate interval:&interval forDate:newDate];
    
    if (complet) {
        endDate = [starDate dateByAddingTimeInterval:interval-1];
    }else {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale currentLocale];
    formatter.dateFormat = @"yyyyMMdd";
    NSString *starStr = [formatter stringFromDate:starDate];
    NSString *endStr = [formatter stringFromDate:endDate];
    
    NSLog(@"%@-%@",starStr,endStr);
    
    return @[starStr,endStr];
    
}






#pragma mark - 查询并且展示数据 

-(void)ssssssssssssssssssweek{
    
    NSArray *datas = [self weekqueryProcessingData:1];
    
    
    NSMutableArray *countArray = [NSMutableArray array];
    
    
    CGFloat stiTime = 0;
    int stiCount = 0;
    CGFloat huodongshijian = 0;
    int step = 0;
    CGFloat licheng = 0;
    CGFloat kaluli = 0;
    
    
    for (int i = 0; i < datas.count; i++) {
        NSDictionary *dic = datas[i];
        [countArray addObject:dic[@"stepStr"]];
        
        
        if (i == 0) {
            
            NSDateFormatter *dateForm = [self dateFormatter];
            dateForm.dateFormat = @"yyyyMMdd";
            NSDate *date = [dateForm dateFromString:dic[@"dateStr"]];
            
            dateForm.dateFormat = @"MM月dd日";
            _dateLable.text = [dateForm stringFromDate:date];
            
            dateForm.dateFormat = @"EE";
            _weekLable.text = [dateForm stringFromDate:date];
        }
        
        
        stiTime += [dic[@"stiTime"] floatValue];
        stiCount += [dic[@"stiCount"] intValue];
        huodongshijian += [dic[@"huodongshijian"] floatValue];
        step += [dic[@"stepStr"] intValue];
        licheng += [dic[@"kmStr"] floatValue];
        kaluli += [dic[@"kcaStr"] floatValue];
    }
    
    
    [self laodTopView:countArray type:11];
    
    
    _stiTimeLable.text = [NSString stringWithFormat:@"%.f",stiTime];
    _stiCountLable.text = [NSString stringWithFormat:@"%d",stiCount];
    _huodongshijianLable.text = [NSString stringWithFormat:@"%.f",huodongshijian];
    _stepLable.text = [NSString stringWithFormat:@"%d",step];
    _lichengLable.text = [NSString stringWithFormat:@"%.2f",licheng];
    _kaluli.text = [NSString stringWithFormat:@"%.2f",kaluli];
    
    
}



-(void)ssssssssssssssssssmouth{

    NSArray *datas = [self weekqueryProcessingData:2];
    
    
    NSMutableArray *countArray = [NSMutableArray array];
    
    CGFloat stiTime = 0;
    int stiCount = 0;
    CGFloat huodongshijian = 0;
    int step = 0;
    CGFloat licheng = 0;
    CGFloat kaluli = 0;
    
    for (int i = 0; i < datas.count; i++) {
        NSDictionary *dic = datas[i];
        [countArray addObject:dic[@"stepStr"]];
        
        
        if (i == 0) {
            
            NSDateFormatter *dateForm = [self dateFormatter];
            dateForm.dateFormat = @"yyyyMMdd";
            NSDate *date = [dateForm dateFromString:dic[@"dateStr"]];
            
            dateForm.dateFormat = @"MM月dd日";
            _dateLable.text = [dateForm stringFromDate:date];
            
            dateForm.dateFormat = @"EE";
            _weekLable.text = [dateForm stringFromDate:date];
        }
        
        
        stiTime += [dic[@"stiTime"] floatValue];
        stiCount += [dic[@"stiCount"] intValue];
        huodongshijian += [dic[@"huodongshijian"] floatValue];
        step += [dic[@"stepStr"] intValue];
        licheng += [dic[@"kmStr"] floatValue];
        kaluli += [dic[@"kcaStr"] floatValue];
    }
    
    [self laodTopView:countArray type:12];

    
    
    
    _stiTimeLable.text = [NSString stringWithFormat:@"%.f",stiTime];
    _stiCountLable.text = [NSString stringWithFormat:@"%d",stiCount];
    _huodongshijianLable.text = [NSString stringWithFormat:@"%.f",huodongshijian];
    _stepLable.text = [NSString stringWithFormat:@"%d",step];
    _lichengLable.text = [NSString stringWithFormat:@"%.2f",licheng];
    _kaluli.text = [NSString stringWithFormat:@"%.2f",kaluli];
}







#pragma mark - 添加表底边的时间  表底部的时间   日 周  月
-(UIView *)addTimeAtTheBottomOfTheTable:(int) type{

    
    CGFloat width = _base_view.frame.size.width;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 21)];
    view.backgroundColor = [UIColor clearColor];
    
    
    if (type == 0) {
        
        NSArray *times = @[@"00:00",@"06:00",@"12:00",@"18:00",@"24:00"];
        for (int i = 0; i < 5; i++) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(i * width * 0.2, 0, width * 0.2, 21)];
            lable.font = [UIFont systemFontOfSize:11];
            lable.textColor = [UIColor whiteColor];
            lable.backgroundColor = [UIColor clearColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.text = times[i];
            [view addSubview:lable];
        }
        
    }else if (type == 1){
    
        NSArray *times = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
        for (int i = 0; i < 7; i++) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(i * (width / 7), 0, (width / 7), 21)];
            lable.font = [UIFont systemFontOfSize:11];
            lable.textColor = [UIColor whiteColor];
            lable.backgroundColor = [UIColor clearColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.text = times[i];
            [view addSubview:lable];
        }
    }else if (type == 2){
    
        NSArray *times = @[@"一号",@"六号",@"十一",@"十六",@"二十一",@"二十六"];
        for (int i = 0; i < 6; i++) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(i * (width / 6), 0, (width / 6), 21)];
            lable.font = [UIFont systemFontOfSize:11];
            lable.textColor = [UIColor whiteColor];
            lable.backgroundColor = [UIColor clearColor];
            lable.textAlignment = NSTextAlignmentLeft;
            lable.text = times[i];
            [view addSubview:lable];
        }
    
    }
    
    
    [_base_view addSubview:view];
    
    return view;
}






#pragma 分析单次活动睡眠时间

-(NSArray *)ssssssssss:(NSArray *)current{
    int countActivity = 0;   //活动个数
    int countSit = 0;        //久坐个数
    
    NSMutableArray *indexs = [NSMutableArray array];
//
//    
    for (int i = 0; i < current.count - 1; i++){
        
        person *per = current[i];
        person *per1 = current[i ];
        
        if (i >= 12 && i <= 42) {
            
//            if ([per.bushu intValue] == 65535 || [per.bushu intValue] == 0) {
            
                if ([per.bushu intValue] != [per1.bushu intValue]) {
                    [indexs addObject:@(i)];
                }
                
//            }
        }
        
        
        
        
        
        
//        if ([per.bushu intValue] == 0) {
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
            

            
            if (([indexs[i + 1] intValue] - [indexs[i] intValue]) >= 3) {
                if ([per.bushu intValue] != 65535 && [per.bushu intValue] == 0) {
                    countSit++;
                    sitTime += 0.5 * ([indexs[i + 1] intValue] - [indexs[i] intValue]);
                }
            }
            
            
            if (([per.bushu intValue] != 65535 && [per.bushu intValue] != 0)) {
                countActivity++;
                activityTime += 0.5 * ([indexs[i + 1] intValue] - [indexs[i] intValue]);
            }
        }
    }

    
    NSString *stiTimeLable = [NSString stringWithFormat:@"%.f",sitTime *  30];
    NSString *stiCountLable = [NSString stringWithFormat:@"%d",countSit];
    NSString *huodongshijianLable = [NSString stringWithFormat:@"%.1f",activityTime * 30];
    
//    NSString *stiTimeLable = [NSString stringWithFormat:@"%.f",countSit * 0.5 *  30];
//    NSString *stiCountLable = [NSString stringWithFormat:@"%d",countSit];
//    NSString *huodongshijianLable = [NSString stringWithFormat:@"%.1f",countActivity * 0.5 * 30];
    
    
    return @[stiTimeLable,stiCountLable,huodongshijianLable];
    
}

@end
