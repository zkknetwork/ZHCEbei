//
//  FeedbackViewController.m
//  Ebei
//
//  Created by 智恒创 on 15/9/13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "FeedbackViewController.h"
@interface FeedbackViewController ()<UITextViewDelegate>{
    
    __weak IBOutlet UITextView *_textView;
    __weak IBOutlet UILabel *labelStr;
}

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"反馈";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    

}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    labelStr.hidden=YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([_textView.text isEqualToString:@""]) {
        labelStr.hidden=NO;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
