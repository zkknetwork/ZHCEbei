//
//  HeightViewController.m
//  Ebei
//
//  Created by 金瑞德科技 on 15-9-9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HeightViewController.h"
#import "oldViewController.h"
@interface HeightViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imag_man;

@end

@implementation HeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(_isman||[[[NSUserDefaults standardUserDefaults] valueForKey:@"sender"] isEqualToString:@"0"]){
        [_imag_man setImage:[UIImage imageNamed:@"男人"]];
   
    }else{
        [_imag_man setImage:[UIImage imageNamed:@"女人"]];
    }
    UIImageView *imageview =[[UIImageView alloc]init];
    imageview.image=[UIImage imageNamed:@"身高102.png"];
    CGFloat imw=imageview.image.size.width;
    CGFloat imh=imageview.image.size.height;
    imageview.frame = CGRectMake(0, 0, imw, imh);
    [self.scrollview addSubview:imageview];
    self.scrollview.contentSize = imageview.image.size;
    _scrollview.showsHorizontalScrollIndicator = NO;
      _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.bounces = NO;
    _scrollview.delegate=self;


}
- (IBAction)back_home:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next_step:(id)sender {
    oldViewController *old = [[oldViewController alloc]initWithNibName:@"oldViewController" bundle:nil];
    old.isman = _isman;
    [self.navigationController pushViewController:old animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    CGFloat y1=scrollView.frame.origin.y;
    float h=0;
    if (y<=25) {
        h=2.5;
    }
    else{
        h=2.5-(y-25)/7*0.01-25/7*0.01;
    }
    NSLog(@"%.2f",h);
  _myhight.text=[NSString stringWithFormat:@"%.2fm",h];
    
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    [userdefaults setObject:[NSString stringWithFormat:@"%.2f",h] forKey:@"height"];
    [userdefaults synchronize];
    
    }


@end
