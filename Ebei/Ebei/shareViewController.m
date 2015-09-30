//
//  shareViewController.m
//  Ebei
//
//  Created by 李玉坤 on 15/9/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "shareViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <AGCommon/UIDevice+Common.h>

@interface shareViewController ()

@end

@implementation shareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //TODO: 第六步：开始使用 ShareSDK 进行分享，详见 wiki 上关于构造分享的例子
//    
//    id<ISSContainer> container = [ShareSDK container];
//    
//    if ([[UIDevice currentDevice] isPad])
//        [container setIPadContainerWithView:0
//                                arrowDirect:UIPopoverArrowDirectionUp];
//    else
//        [container setIPhoneContainerWithViewController:self];
//    
//    //    id<ISSShareActionSheetItem> item1 = [ShareSDK shareActionSheetItemWithTitle:@"新浪微博"
//    //                                                                           icon:[UIImage imageNamed:@"sina"]
//    //                                                                   clickHandler:^{
//    //
//    //                                                                       NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"http://www.jiathis.com/send/?webid=tsina&url=%@&title=%@",kGlobalManager.serviceUrl,[kGlobalManager.loginUserInfo.bind stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
//    //                                                                       [[UIApplication sharedApplication] openURL:url];
//    //
//    //                                                                   }];
//    
//    
//    
//    NSArray *shareList = [ShareSDK customShareListWithType:
//                          SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
//                          SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
//                          SHARE_TYPE_NUMBER(ShareTypeQQ),
//                          //                          item1,
//                          
//                          nil];
//    
//    
//    id<ISSContent> publishContent = nil;
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"1"  ofType:@"jpg"];
//    
//    NSString *contentString = [NSString stringWithFormat:@"%@",@"已经分享锅里啦"];
//    NSString *titleString   = @"";
//    NSString *urlString     =[NSString stringWithFormat:@"http://appsrv.ihodoo.com/share/weixin?activityId=%@",@""];
//    NSString *description   =@"";
//    
//    
//    publishContent = [ShareSDK content:contentString
//                        defaultContent:description
//                                 image:[ShareSDK imageWithPath:imagePath]
//                                 title:titleString
//                                   url:urlString
//                           description:description
//                             mediaType:SSPublishContentMediaTypeNews];
//    id<ISSShareOptions> shareOptions =
//    [ShareSDK defaultShareOptionsWithTitle:@"分享"
//                           oneKeyShareList:shareList
//                        cameraButtonHidden:YES
//                       mentionButtonHidden:NO
//                         topicButtonHidden:NO
//                            qqButtonHidden:YES
//                     wxSessionButtonHidden:YES
//                    wxTimelineButtonHidden:YES
//                      showKeyboardOnAppear:NO
//                         shareViewDelegate:nil
//                       friendsViewDelegate:nil
//                     picViewerViewDelegate:nil];
//    
//    //自定义copy内容
//    [publishContent addCopyUnitWithContent:urlString image:nil];
//    
//    
//    [ShareSDK showShareActionSheet:container
//                         shareList:shareList
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions:shareOptions
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end)
//     {
//         NSString *name = nil;
//         switch (type)
//         {
//                 //             case ShareTypeQQ:
//                 //                 name = @"QQ";
//                 //                 break;
//                 //             case ShareTypeSinaWeibo:
//                 //                 name = @"新浪微博";
//                 //                 break;
//             case ShareTypeQQ:
//                 name = @"QQ";
//                 break;
//             case ShareTypeWeixiSession:
//                 name = @"微信";
//                 break;
//             case ShareTypeWeixiTimeline:
//                 name = @"微信朋友圈";
//                 break;
//                              
//             default:
//                 name = @"某个平台";
//                 break;
//         }
//         
//         NSString *notice = nil;
//         if (state == SSPublishContentStateSuccess)
//         {
//             notice = [NSString stringWithFormat:@"%@成功！", name];
//             
//             UIAlertView *view =
//             [[UIAlertView alloc] initWithTitle:@"提示"
//                                        message:notice
//                                       delegate:nil
//                              cancelButtonTitle:@"知道了"
//                              otherButtonTitles: nil];
//             [view show];
//         }
//         else if (state == SSPublishContentStateFail)
//         {
//             notice = [NSString stringWithFormat:@"分享到%@失败,错误码:%d,错误描述:%@", name, [error errorCode], [error errorDescription]];
//             
//             UIAlertView *view =
//             [[UIAlertView alloc] initWithTitle:@"提示"
//                                        message:notice
//                                       delegate:nil
//                              cancelButtonTitle:@"知道了"
//                              otherButtonTitles: nil];
//             [view show];
//         }
//     }];
//    
//    
//    
//    
//    
//
//    
//    
//    
//
}
//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)back_home:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
