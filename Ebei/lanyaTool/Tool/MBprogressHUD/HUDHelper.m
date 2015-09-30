//
//  HUDHelper.m
//  Stock
//
//  Created by 周敏 on 13-7-13.
//  Copyright (c) 2013年 zhoumin. All rights reserved.
//

#import "HUDHelper.h"

@implementation HUDHelper

+ (MBProgressHUD*)progressViewWithTitile:(NSString*)title InView:(UIView*)inView
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:inView];
    [inView addSubview:hud];
    if (title.length) {
        hud.labelText = title;
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    return hud;
}

+ (MBProgressHUD*)showProgressViewWithTitile:(NSString*)title InView:(UIView*)inView
{
    MBProgressHUD *hud = [HUDHelper progressViewWithTitile:title InView:inView];
    [hud show:YES];
    return hud;
}

+ (void)showNetWorkErroWarningInView:(UIView*)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.labelText = @"您当前的网络异常";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"warning_network.png"]];
    hud.customView = imageView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.needHiddenWhenTaped = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:10];
}

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title delay:(NSTimeInterval)delay
{
    [HUDHelper showPromptViewTappedHideInView:view Title:title delay:delay center:CGPointZero];
}

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title detail:(NSString*)detail delay:(NSTimeInterval)delay
{
    [HUDHelper showPromptViewTappedHideInView:view Title:title detail:detail delay:delay center:CGPointZero];
}

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title delay:(NSTimeInterval)delay center:(CGPoint)point
{
    [HUDHelper showPromptViewTappedHideInView:view Title:title detail:nil delay:delay center:CGPointZero];
}

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title detail:(NSString*)detail delay:(NSTimeInterval)delay center:(CGPoint)point {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    if (title) {
        hud.labelText = title;
    }
    if (detail) {
        hud.detailsLabelText = detail;
    }
    if (!CGPointEqualToPoint(point, CGPointZero)) {
        hud.center = point;
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.needHiddenWhenTaped = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}

+ (void)showPromptViewInWindow:(NSString*)image message:(NSString*)message
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    if (windows.count==0) {
         return;
    }
    UIWindow *window = [windows lastObject];
    [HUDHelper showPromptViewTappedHideInView:window image:image title:message detail:nil delay:2];
}

+ (void)showPromptViewTappedHideInView:(UIView*) view  image:(NSString*)image title:(NSString*)title detail:(NSString*)detail delay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    hud.customView = imageView;
    
    hud.labelText = title;
    hud.labelFont = [UIFont boldSystemFontOfSize:15.0f];
    
    hud.detailsLabelText = detail;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:13.0f];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.needHiddenWhenTaped = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}

+ (void)showMessag:(NSString *)message
{
//    int width = 0;
//    
//    if(message.length <= 10){
//        width = message.length*10;
//    }else{
//        width = kDeviceWidth*2/3;
//    
//    }
//    
//    UIFont *font1 = [UIFont systemFontOfSize:16];
//    
//    //计算label的高度
//    CGSize size1 = CGSizeMake(width,MAXFLOAT);
//    CGRect labelRect1 = [message boundingRectWithSize:size1 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName] context:nil];
//   UILabel * view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, labelRect1.size.height)];
//    
//    
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
//    [view addSubview:hud];
//    
//      hud.customView = view;
//    hud.mode = MBProgressHUDModeCustomView;
//
//    [hud show:YES];
//    [hud hide:YES afterDelay:1.0f];
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:hud];
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont systemFontOfSize:13];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.margin = 10.f;
    //hud.lineBreakMode = UILineBreakModeWordWrap;
    
    [hud show:YES];
    [hud hide:YES afterDelay:1.0f];
}


@end
