//
//  NETWork.h
//  Ebei
//
//  Created by 黎峰麟 on 15/9/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NETWork : NSObject

//注册
// http://112.74.27.169:8001/ebelt/login/registe?phone=13510610442&sms_code=386884&password=sjdf

//登陆
// http://112.74.27.169:8001/ebelt/login/login1?phone=13510610442&password=sjdf

//忘记密码
// http://112.74.27.169:8001/ebelt/login/forget_pass?phone=13510610442&sms_code=866778&newpass=kkk

//登出
// http://112.74.27.169:8001/ebelt/user/logout?scode=kSV98quY5i1LAJqLIzbbVJXC4xSUCIx0

//修改密码
// http://112.74.27.169:8001/ebelt/user/modify_pass?scode=HXKDY6jFnxxb32gZFTGibeRYBlMGgypD&oldpass=334&newpass=88

//检查版本号
// http://112.74.27.169:8001/ebelt/system/version?app=ebelt&ver=2

+(void)request: (NSString*)urlStr Success:(void (^)(NSDictionary *mdoel))success failed:(void (^)(NSError *error))failed;
@end
