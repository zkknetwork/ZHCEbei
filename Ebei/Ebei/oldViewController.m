//
//  oldViewController.m
//  Ebei
//
//  Created by 李玉坤 on 15/9/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "oldViewController.h"
#import "heavyViewController.h"
#import "macro.h"
@interface oldViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imag_man;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end

@implementation oldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"%f",self.view.frame.size.height);
     NSLog(@"%f",kScreenHeight);
    if (kScreenHeight==480) {
        
        _imag_man.frame=CGRectMake(kScreenWidth/2-37, 60, 74, 185);
        _myhight.frame=CGRectMake(kScreenWidth/2-143/2, _imag_man.frame.origin.y+200, 143, 21);
        _backView.frame=CGRectMake(0, _myhight.frame.origin.y+30, kScreenWidth, 72);
        _nextBtn.frame=CGRectMake(kScreenWidth/2-230/2, self.view.frame.size.height-60, 230, 33);
        
    }
    
    


    
    if(_isman||[[[NSUserDefaults standardUserDefaults] valueForKey:@"sender"] isEqualToString:@"0"]){
        [_imag_man setImage:[UIImage imageNamed:@"男人"]];
        
    }else{
        [_imag_man setImage:[UIImage imageNamed:@"女人"]];
    }
    
    UIImageView *imageview =[[UIImageView alloc]init];
    imageview.image=[UIImage imageNamed:@"年龄103.png"];
    CGFloat imw=imageview.image.size.width;
    CGFloat imh=imageview.image.size.height;
    imageview.frame = CGRectMake(0, 0, imw, imh);
    [self.scrollview addSubview:imageview];
    self.scrollview.contentSize = imageview.image.size;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.bounces = NO;
    _scrollview.delegate=self;

    // Do any additional setup after loading the view from its nib.
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
    heavyViewController *heavy = [[heavyViewController alloc]initWithNibName:@"heavyViewController" bundle:nil];
    heavy.isman = _isman;
    [self.navigationController pushViewController:heavy animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.x;
   // CGFloat y1=scrollView.frame.origin.y;
        int h=0;
   // if (y<=40) {
     //   h=1899;
   // }
  //  else{
        h=1900+y/(1154.0/105.0);
  //  }
    NSLog(@"%f",y);
    _myhight.text=[NSString stringWithFormat:@"%d年出生",h];
   
}


@end
