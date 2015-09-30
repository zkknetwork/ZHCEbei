//
//  HUDHelper.h
//  Stock
//
//  Created by 周敏 on 13-7-13.
//  Copyright (c) 2013年 zhoumin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define HUD_WARN                @"MBProgressHUD.bundle/images/mb_warn"
#define HUD_ERROR               @"MBProgressHUD.bundle/images/mb_error"
#define HUD_SUCCESS             @"MBProgressHUD.bundle/images/mb_success"
#define NETWORK_WARN            @"MBProgressHUD.bundle/images/network_warning"

@interface HUDHelper : NSObject

+ (MBProgressHUD*)progressViewWithTitile:(NSString*)title InView:(UIView*)inView;

+ (MBProgressHUD*)showProgressViewWithTitile:(NSString*)title InView:(UIView*)inView;

+ (void)showNetWorkErroWarningInView:(UIView*)view;

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title delay:(NSTimeInterval)delay;

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title detail:(NSString*)detail delay:(NSTimeInterval)delay;

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title delay:(NSTimeInterval)delay center:(CGPoint)point;

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title detail:(NSString*)detail delay:(NSTimeInterval)delay center:(CGPoint)point;

+ (void)showPromptViewInWindow:(NSString*)image message:(NSString*)message;

+ (void)showPromptViewTappedHideInView:(UIView*) view  image:(NSString*)image title:(NSString*)title detail:(NSString*)detail delay:(NSTimeInterval)delay;

+ (void)showMessag:(NSString *)message;

@end
