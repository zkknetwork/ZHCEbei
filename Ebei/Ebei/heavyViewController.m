//
//  heavyViewController.m
//  Ebei
//
//  Created by 李玉坤 on 15/9/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "heavyViewController.h"
#import "yaoweiViewController.h"
#import "WTTouchview.h"
#import "macro.h"
@interface heavyViewController ()<weightDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imag_man;

@end

@implementation heavyViewController

-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (kScreenHeight==480) {
        
        _imag_man.frame=CGRectMake(kScreenWidth/2-37, 60, 74, 185);
        _tizhong.frame=CGRectMake(kScreenWidth/2-280/2, _imag_man.frame.origin.y+240, 280, 280);

        _myWeight.frame=CGRectMake(kScreenWidth/2-117/2, _imag_man.frame.origin.y+290, 117, 21);
        
        
        _redLine.frame=CGRectMake(kScreenWidth/2-1/2, _imag_man.frame.origin.y+230, 1, 30);
        
        
        _backLabel.frame=CGRectMake(0, _imag_man.frame.origin.y+320, kScreenWidth, 280);
        
        _nextBtn.frame=CGRectMake(kScreenWidth/2-230/2, self.view.frame.size.height-60, 230, 33);
        
    }
    

    
    
    
    _myWeight.textAlignment=NSTextAlignmentCenter;
    if(_isman||[[[NSUserDefaults standardUserDefaults] valueForKey:@"sender"] isEqualToString:@"0"]){
        [_imag_man setImage:[UIImage imageNamed:@"男人"]];
        
    }else{
        [_imag_man setImage:[UIImage imageNamed:@"女人"]];
    }
    WTTouchview *wt=[WTTouchview sharedInstance];
    wt.frame=CGRectMake(0, 0, 293, 293);
    wt.delegate=self;
    [self.tizhong addSubview:wt];
    }
-(void)setWeight:(NSString *)weight{
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"weight"]) {
        
        _myWeight.text=[NSString stringWithFormat:@"%@kg",[[NSUserDefaults standardUserDefaults] valueForKey:@"weight"]];
        _myWeight.textAlignment=NSTextAlignmentCenter;
    }else{
        
    }

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
- (IBAction)back_home:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)next_step:(id)sender {
    yaoweiViewController *yaowei = [[yaoweiViewController alloc]initWithNibName:@"yaoweiViewController" bundle:nil];
    yaowei.isman = _isman;
    [self.navigationController pushViewController:yaowei animated:YES];
}

@end
