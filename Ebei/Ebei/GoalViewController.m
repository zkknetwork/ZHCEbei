//
//  GoalViewController.m
//  demo
//
//  Created by 智恒创 on 15/9/22.
//  Copyright (c) 2015年 zhc. All rights reserved.
//

#import "GoalViewController.h"
#define Duration 0.2
@interface GoalViewController (){
    UILabel *stepNum;
    UIButton *progressGo;
    BOOL contain;
    CGPoint startPoint;
    CGPoint originPoint;
    UIImageView *progressImg;
    UISlider *slider;
    UILabel *step;
    UILabel *meterNum;
    UILabel * calorie;
}

@end

@implementation GoalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubView];
    
    
}
-(void)labelFrame{
    
}

-(void)addSubView{
     self.view.backgroundColor=[UIColor whiteColor];
    
    
    
   
    
    
    UIImageView  *topImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,2*self.view.frame.size.height/3 )];
    [topImageView setImage:[UIImage imageNamed:@"背景.jpg"]];
    [self.view addSubview:topImageView];
    
    
    
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-40,20 , 80, 40)];
    
    title.text=@"目标";
    title.textAlignment=NSTextAlignmentCenter;
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:title];
    
    
    
    
    
    stepNum=[[UILabel alloc] init];
    stepNum.textColor=[UIColor whiteColor];
    [self.view addSubview:stepNum];
    
    
    if ([[NSUserDefaults  standardUserDefaults] valueForKey:@"goal"]) {
        stepNum.text=[[NSUserDefaults  standardUserDefaults] valueForKey:@"goal"];
    }else{
         stepNum.text=@"5000";
        //存储用户信息
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:stepNum.text forKey:@"goal"];//用户目标
        
        [userDefaults synchronize];
        

       
    }
    
    // 设置Label的字体 HelveticaNeue  Courier
    UIFont *fnt = [UIFont fontWithName:@"Arial" size:35.0f];
    stepNum.font = fnt;
    // 根据字体得到NSString的尺寸
    CGSize size = [stepNum.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
    // 名字的H
    CGFloat nameH = size.height;
    // 名字的W
    CGFloat nameW = size.width;
    stepNum.frame = CGRectMake(self.view.frame.size.width/2-nameW/2, 150, nameW,nameH);
    
    
    
    step=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+nameW/2+5, stepNum.frame.origin.y+nameH-20, 20, 20)];
    step.text=@"步";
    step.textColor=[UIColor whiteColor];
    [self.view addSubview:step];
    
    
    UIButton  *bottomImageView=[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.width/3- 1*self.view.frame.size.height/4, self.view.frame.size.width,self.view.frame.size.width/3 )];
    [bottomImageView setBackgroundImage:[UIImage imageNamed:@"后水.png"] forState:normal];
    [bottomImageView setBackgroundImage:[UIImage imageNamed:@"后水.png"] forState:UIControlStateHighlighted];
    [bottomImageView setImage:[UIImage imageNamed:@"前水.png"]forState:normal ];
    [bottomImageView setImage:[UIImage imageNamed:@"前水.png"] forState:UIControlStateHighlighted ];
    [self.view addSubview:bottomImageView];
    
    meterNum=[[UILabel alloc] initWithFrame:CGRectMake(0, bottomImageView.frame.origin.y+40, self.view.frame.size.width/2-1, 30)];
    meterNum.text=@"0";
    meterNum.textColor=[UIColor grayColor];
    meterNum.font=[UIFont systemFontOfSize:20];
    meterNum.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:meterNum];
    
    
    UILabel*  meterNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, bottomImageView.frame.origin.y+70, self.view.frame.size.width/2-1, 20)];
    meterNumLabel.text=@"距离(km)";
    meterNumLabel.textColor=[UIColor grayColor];
    meterNumLabel.font=[UIFont systemFontOfSize:14];
    meterNumLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:meterNumLabel];

    
    
    
    calorie=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+1, bottomImageView.frame.origin.y+40, self.view.frame.size.width/2-1, 30)];
    calorie.text=@"0";
    calorie.textColor=[UIColor grayColor];
     calorie.font=[UIFont systemFontOfSize:20];
    calorie.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:calorie];
    
    
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
    
    
    
    CGFloat juli = [height floatValue] * [stepNum.text intValue] * 0.0036;
    meterNum.text = [NSString stringWithFormat:@"%.2f",juli];
    calorie.text = [NSString stringWithFormat:@"%.2f",[weight floatValue] * juli * 0.636];
    

    
    
    
   UILabel* calorieLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+1, bottomImageView.frame.origin.y+70, self.view.frame.size.width/2-1, 20)];
    calorieLabel.text=@"卡路里（kJ）";
    calorieLabel.textColor=[UIColor grayColor];
    calorieLabel.font=[UIFont systemFontOfSize:14];
    calorieLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:calorieLabel];
    
    
    
    
    
    progressImg=[[UIImageView alloc] initWithFrame:CGRectMake(30, meterNum.frame.origin.y+80, self.view.frame.size.width-60, 10)];
    progressImg.layer.cornerRadius=11/2;
    progressImg.layer.masksToBounds =YES;
    progressImg.image=[UIImage imageNamed:@"进度底.png"];
    
    [self.view addSubview:progressImg];
    
    slider = [[UISlider alloc] initWithFrame:CGRectMake(20, meterNum.frame.origin.y+65, self.view.frame.size.width-40, 40)];
    [slider setThumbImage:[UIImage imageNamed:@"未达标.png"] forState:normal];
    slider.minimumTrackTintColor=[UIColor clearColor];
    slider.maximumTrackTintColor=[UIColor clearColor];
    slider.backgroundColor=[UIColor clearColor];
    slider.value = ([stepNum.text floatValue] - 5000) * 0.0001;
    
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    
    
    if([stepNum.text floatValue]<8000){
        [slider setThumbImage:[UIImage imageNamed:@"未达标.png"] forState:normal];
    }
    else if ([stepNum.text floatValue]>8000&&[stepNum.text floatValue]<11000) {
        [slider setThumbImage:[UIImage imageNamed:@"达标.png"] forState:normal];
    }else{
        [slider setThumbImage:[UIImage imageNamed:@"超标.png"] forState:normal];
    }
    
}

- (void)sliderChange:(UISlider *)s {
    
    NSInteger num=5000+s.value*10000;
    
    ;
    stepNum.text=[NSString stringWithFormat:@"%d",num];
  
    NSString *height = [[NSUserDefaults standardUserDefaults] objectForKey:@"height"];  //米
    NSString *weight = [[NSUserDefaults standardUserDefaults] objectForKey:@"weight"];  //千克
    if (height == nil) {
        height = @"1.7";
    }
    
    if (weight == nil) {
        weight = @"60";
    }
    
    
    
    CGFloat juli = [height floatValue] * [stepNum.text intValue] * 0.0036;
    meterNum.text = [NSString stringWithFormat:@"%.2f",juli];
    calorie.text = [NSString stringWithFormat:@"%.2f",[weight floatValue] * juli * 0.636];
    

    
    //存储用户信息
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:stepNum.text forKey:@"goal"];//用户目标
    
    [userDefaults synchronize];

    
    
    
    // 设置Label的字体 HelveticaNeue  Courier
    UIFont *fnt = [UIFont fontWithName:@"Arial" size:35.0f];
    stepNum.font = fnt;
    // 根据字体得到NSString的尺寸
    CGSize size = [stepNum.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
    // 名字的H
    CGFloat nameH = size.height;
    // 名字的W
    CGFloat nameW = size.width;
    stepNum.frame = CGRectMake(self.view.frame.size.width/2-nameW/2, 100, nameW,nameH);
    
    step.frame= CGRectMake(self.view.frame.size.width/2+nameW/2+5, stepNum.frame.origin.y+nameH-20, 20, 20);
    
    
    if(num<8000){
         [slider setThumbImage:[UIImage imageNamed:@"未达标.png"] forState:normal];
    }
   else if (num>8000&&num<11000) {
          [slider setThumbImage:[UIImage imageNamed:@"达标.png"] forState:normal];
    }else{
          [slider setThumbImage:[UIImage imageNamed:@"超标.png"] forState:normal];
    }
    
//    two.center = CGPointMake(290, 50 + s.value * 100);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
