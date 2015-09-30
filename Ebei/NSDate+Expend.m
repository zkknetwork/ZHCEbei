//
//  NSDate+Expend.m
//  WklBleDemo
//
//  Created by baoyx on 15/7/10.
//  Copyright (c) 2015年 baoyx. All rights reserved.
//

#import "NSDate+Expend.h"

@implementation NSDate (Expend)
-(NSString *)pubGetYearAndMonthAndDay
{
    return [[self privateGetCurrentDate] substringWithRange:NSMakeRange(0,8)];
}
#pragma mark 获取当前时间字符串字符串
-(NSString *)privateGetCurrentDate
{
    struct tm *timeinfo;
    char buffer[80];
    
    time_t rawtime = [self timeIntervalSince1970];
    timeinfo = localtime(&rawtime);
    strftime(buffer, 80, "%Y%m%d%H%M%S", timeinfo);
    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}
@end
