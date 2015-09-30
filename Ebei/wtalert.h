//
//  wtalert.h
//  HCZRuning
//
//  Created by MAC on 15/5/28.
//  Copyright (c) 2015年 HCZRuning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface wtalert : NSObject
@property NSString *a;
+ (wtalert*) sharedInstance;
-(void)jinggao:(NSString *)s;
-(void)xiaoshi;
@property BOOL haobu;
@property BOOL chuchun;
@property BOOL weiyi;
@end
