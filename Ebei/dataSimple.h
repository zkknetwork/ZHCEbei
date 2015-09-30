//
//  dataSimple.h
//  数据库FMDB
//
//  Created by qianfeng on 13-7-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface dataSimple : NSObject{
     FMDatabase *database;
}
@property (nonatomic, readonly)FMDatabase *database;
+(dataSimple *)sharedDataBase;
- (id)init;
@end
