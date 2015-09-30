//
//  BlueWriteTool.m
//  BlueTool
//
//  Created by 黎峰麟 on 15/9/26.
//  Copyright © 2015年 zhc. All rights reserved.
//

#import "BlueWriteTool.h"

@implementation BlueWriteTool


+(NSData *)blueWriteTool:(NSDate *)date{

    NSDate *now = date;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    Byte cc[]={
        0x5a,
        0x01,
        0x00,
        [dateComponent year]-2000,
        [dateComponent month],
        [dateComponent day],
        [dateComponent hour],
        [dateComponent minute],
        [dateComponent second],10,00,03,00,0x78,00,00,00,00,00,00};
    NSData *dataWrite = [NSData dataWithBytes:&cc length:20];
    
    
    return dataWrite;
}


+ (NSData *)blueWriteToolStar:(NSDate *)starDate endDate:(NSDate *)endDate data:(NSData *)data{

    NSUInteger length = data.length;
    unsigned char *testByte = malloc(length);
    [data getBytes:testByte];
    
    
//    NSDate *now = [NSDate date];
    NSDate *now = starDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar]; 
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    
    
//    [dateComponent year]-2000,
//    [dateComponent month],
//    [dateComponent day],
    
    
    Byte cc[]={0x5a,0x03,0x00,
        [dateComponent year]-2000,
        [dateComponent month],
        [dateComponent day],
        [dateComponent year]-2000,
        [dateComponent month],
        [dateComponent day],
        testByte[3],testByte[4],testByte[5],testByte[6],testByte[7],testByte[8],testByte[9],testByte[10],00,00,00};
    NSData *dataWrite = [NSData dataWithBytes:&cc length:20];
    
    return dataWrite;
}


+ (NSData *)blueWriteToolQueryPower{

    Byte cc[]={0x5a,0x0d,0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
    NSData *dataWrite = [NSData dataWithBytes:&cc length:20];
    
    return dataWrite;
}



+(NSData *)blueWriteToolsedentaryReminder:(int)isOpen timeInterval:(NSString *)interval starTime:(NSString *)star endTime:(NSString *)end{
    
    //0x02
    
    NSArray *intervals = [interval componentsSeparatedByString:@":"];
    NSArray *stars = [star componentsSeparatedByString:@":"];
    NSArray *ends = [end componentsSeparatedByString:@":"];

//    Byte cc[]={
//        0x02,
//        isOpen,
//        [intervals[0] intValue],
//        [intervals[1] intValue],
//        [stars[0] intValue],
//        [stars[1] intValue],
//        [ends[0] intValue],[ends[1] intValue],0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
//    
//    NSData *dataWrite = [NSData dataWithBytes:&cc length:20];
    
    Byte cc[]={
        0x02,
        isOpen,
        [intervals[0] intValue],
        [intervals[1] intValue],
        [stars[0] intValue],
        [stars[1] intValue],
        [ends[0] intValue],
        [ends[1] intValue]};
    
    NSData *dataWrite = [NSData dataWithBytes:&cc length:8];
    
    return dataWrite;
}


@end
