//
//  wtalert.m
//  HCZRuning
//
//  Created by MAC on 15/5/28.
//  Copyright (c) 2015年 HCZRuning. All rights reserved.
//

#import "wtalert.h"

@implementation wtalert
static wtalert *sharedProximityTagStorage = nil;
+ (wtalert*) sharedInstance
{
    if (sharedProximityTagStorage == nil) {
        sharedProximityTagStorage = [[wtalert alloc] init];
    }
    return sharedProximityTagStorage;
}
- (id) init
{
    if(self = [super init])
    {
        _a=@"0";
        self.haobu=YES;
        self.chuchun=YES;
        self.weiyi=YES;
    }
    return self;
}
-(void)jinggao:(NSString *)s{
    UIAlertView* myAlert = [[UIAlertView alloc]
               initWithTitle:@"提示"
               message:[NSString stringWithFormat:@"%@",s]
               delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    myAlert.delegate =    self;
    [myAlert show];
    [self performSelector:@selector(xiaoshi:) withObject:myAlert afterDelay:5.0f];
    

}
-(void)xiaoshi:(UIAlertView *)array{
    
    [array dismissWithClickedButtonIndex:0 animated:NO];
   
    
}
@end
