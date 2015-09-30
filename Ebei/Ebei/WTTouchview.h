//
//  WTTouchview.h
//  Ebei
//
//  Created by MAC on 15/9/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol weightDelegate <NSObject>
@required
@optional
-(void)setWeight:(NSString *)weight;

@end


@interface WTTouchview : UIView
+(WTTouchview *)sharedInstance;
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property(nonatomic ,assign)id <weightDelegate>delegate;
@property NSString *shujv;
@end


