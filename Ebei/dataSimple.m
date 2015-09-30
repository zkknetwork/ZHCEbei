//
//  dataSimple.m
//  数据库FMDB
//
//  Created by qianfeng on 13-7-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "dataSimple.h"
static dataSimple *simple = nil;//单例指针

@implementation dataSimple
@synthesize database;
+(dataSimple *)sharedDataBase{
    if (simple == nil) {
        simple = [[dataSimple alloc]init];
    }
    return simple;
}
- (id)init{
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //导入文件目录
    NSString *docmentPath = [arr lastObject];
    //构建数据库文件的路径
    NSString *dbPath = [docmentPath stringByAppendingPathComponent:@"/Test.db"];
    //创建本地数据库文件
    NSLog(@"%@",dbPath);
    database = [[FMDatabase databaseWithPath:dbPath] retain];
    // 打开数据库
    if (![database open]) {
        NSLog(@"open database error");
        return nil;
    }
    //创建一个表格
    
    NSString *sqlCommand = @"CREATE TABLE IF NOT EXISTS go(id INTEGER PRIMARY KEY AUTOINCREMENT,time TEXT,day TEXT,bushu TEXT,myID TEXT)";//表格的名字叫go
    NSString *sqlCommand1 = @"CREATE TABLE IF NOT EXISTS zongbushu(id INTEGER PRIMARY KEY AUTOINCREMENT,time TEXT,day TEXT,bushu TEXT,myID TEXT)";//表格的名字叫user

    //执行sql语句
    if (![database executeUpdate:sqlCommand]) {
        NSLog(@"create table error");
    }
    if (![database executeUpdate:sqlCommand1]) {
        NSLog(@"create table error");
    }

    return self;
}

- (void)dealloc {
    [database release];
    [super dealloc];
}

@end
