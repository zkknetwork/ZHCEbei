//
//  yaoweiViewController.m
//  Ebei
//
//  Created by 李玉坤 on 15/9/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "yaoweiViewController.h"
#import "mainViewController.h"
#import "ConnectionViewController.h"
#import "macro.h"
@interface yaoweiViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imag_man;
@property (weak, nonatomic) IBOutlet UIImageView *pidaidiView;

@end

@implementation yaoweiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    if (kScreenHeight==480) {
        
        _imag_man.frame=CGRectMake(kScreenWidth/2-37, 60, 74, 185);
        _yaoWei.frame=CGRectMake(kScreenWidth/2-143/2, _imag_man.frame.origin.y+200, 143, 30);
        
        
        _pidaidiView.frame=CGRectMake(24, _yaoWei.frame.origin.y+40, kScreenWidth-48, 46);
        
        
        _scrollView.frame=CGRectMake(kScreenWidth/2-272/2+60, _yaoWei.frame.origin.y+40, 200, 46);
        
        
        
        _keduView.frame=CGRectMake(kScreenWidth/2, _yaoWei.frame.origin.y+56, 9, 9);
        
        
        _nextBtn.frame=CGRectMake(kScreenWidth/2-230/2, self.view.frame.size.height-60, 230, 33);
        
    }else if (kScreenHeight==667){
        
        _scrollView.frame=CGRectMake(78, 369, kScreenWidth-180, 46);
        

    }else if (kScreenHeight==736){
        
        _scrollView.frame=CGRectMake(70, 369, kScreenWidth-200, 46);
        
        
    }
    
    

    if(_isman||[[[NSUserDefaults standardUserDefaults] valueForKey:@"sender"] isEqualToString:@"0"]){
        [_imag_man setImage:[UIImage imageNamed:@"男人"]];
        
    }else{
        [_imag_man setImage:[UIImage imageNamed:@"女人"]];
    }
    
    
    UIImageView *imageview =[[UIImageView alloc]init];
    imageview.image=[UIImage imageNamed:@"点尺.png"];
    CGFloat imw=imageview.image.size.width;
    CGFloat imh=imageview.image.size.height;
    imageview.frame = CGRectMake(1, 0, imw, imh-3);
    [self.scrollView addSubview:imageview];
    self.scrollView.contentSize = imageview.image.size;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate=self;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.x;
    CGFloat h=0;
    if (kScreenHeight==480){
         h=(14.6+y/(1850.0/39.0))*0.1;
    }else if (kScreenHeight==667){
        
        h=(14.5+y/(1850.0/39.0))*0.1;
    }else if (kScreenHeight==736){
        
         h=(14.5+y/(1850.0/39.0))*0.1;
        
    }else
    
         h=(14.5+y/(1850.0/39.0))*0.1;
   
    
    
    NSLog(@"%f",y);
    
    _yaoWei.text=[NSString stringWithFormat:@"%.1f尺",h];
    
    
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    [userdefaults setObject:[NSString stringWithFormat:@"%.1f",h] forKey:@"rule"];
    [userdefaults synchronize];
}

- (IBAction)back_home:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)next_step:(id)sender {
    ConnectionViewController *main = [[ConnectionViewController alloc]initWithNibName:@"ConnectionViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:main];
//    [self.navigationController presentViewController:nav animated:YES completion:nil];
    [self.navigationController pushViewController:main animated:YES];
}

@end
