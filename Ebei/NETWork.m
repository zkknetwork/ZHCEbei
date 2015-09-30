//
//  NETWork.m
//  Ebei
//
//  Created by 黎峰麟 on 15/9/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "NETWork.h"

@implementation NETWork

+(void)request: (NSString*)urlStr Success:(void (^)(NSDictionary *mdoel))success failed:(void (^)(NSError *error))failed{
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, (long)error.code);
                                   
                                   if (failed) {
                                       failed(error);
                                   }
                                   
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"HttpResponseCode:%ld", (long)responseCode);
                                   NSLog(@"HttpResponseBody %@",responseString);
                                   
                                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                   
                                   
                                   if (success) {
                                       success(dic);
                                   }
                               }
                           }];
}
@end
