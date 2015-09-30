//
//  CJNavigationController.m
//  LJSChat
//
//  Created by Nicholas on 15/7/12.
//  Copyright (c) 2015年 Nicholas. All rights reserved.
//

#import "CJNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface CJNavigationController ()

@end

@implementation CJNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"64x320"] forBarMetrics:UIBarMetricsDefault];
    
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        // 设置左边的返回按钮

        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"返回" highImage:@"返回点击"];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
