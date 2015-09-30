//
//  BlueWriteTool.h
//  BlueTool
//
//  Created by 黎峰麟 on 15/9/26.
//  Copyright © 2015年 zhc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlueWriteTool : NSObject

//记步
+ (NSData *)blueWriteTool:(NSDate *)date;
+ (NSData *)blueWriteToolStar:(NSDate *)starDate endDate:(NSDate *)endDate data:(NSData *)data;





//蓝牙电量
+ (NSData *)blueWriteToolQueryPower;

//久坐设置                                             两次提醒间的间隔时长                 功能生效时间段的起始时间      功能生效时间段的结束时间
+(NSData *)blueWriteToolsedentaryReminder:(int)isOpen timeInterval:(NSString *)interval starTime:(NSString *)star endTime:(NSString *)end;

@end
