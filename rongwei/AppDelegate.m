//
//  AppDelegate.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "AppDelegate.h"
#import "DFAppVersionTool.h"
#import "DFTabBarController.h"
#import "WXApi.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     [self setUpRootVC]; //跟控制器判断
    
    [WXApi registerApp:kWXAppKey];
    return YES;
}
#pragma mark - 根控制器
- (void)setUpRootVC
{
    if ([BUNDLE_VERSION isEqualToString:[DFAppVersionTool dc_GetLastOneAppVersion]]) {//判断是否当前版本号等于上一次储存版本号
        
        self.window.rootViewController = [[DFTabBarController alloc] init];
    }else{
        
        //第一次进入
        [DFAppVersionTool dc_SaveNewAppVersion:BUNDLE_VERSION]; //储存当前版本号
        
//        // 设置窗口的根控制器
//        DCNewFeatureViewController *dcFVc = [[DCNewFeatureViewController alloc] init];
//        [dcFVc setUpFeatureAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selColor, BOOL *showSkip, BOOL *showPageCount) {
//
//            *imageArray = @[@"guide1",@"guide2",@"guide3",@"guide4"];
//            *showPageCount = YES;
//            *showSkip = YES;
//        }];
//        self.window.rootViewController = dcFVc;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp*)resp {
    
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        
        SendAuthResp *sendAuthResp = ((SendAuthResp *)resp);
        if ([sendAuthResp.state isEqualToString:@"udoctor"] && sendAuthResp.errCode == 0) {
            
            // 是微信登录成功的回调
            NSString *code = sendAuthResp.code;
//            [self getWeiXinOpenId:code];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWeChatAuthSuccess object:nil userInfo:@{@"code":ISNIL(code)}];
            
        } else {
            
            // 微信登录失败
//              ERR_OK = 0(用户同意) ERR_AUTH_DENIED = -4（用户拒绝授权） ERR_USER_CANCEL = -2（用户取消）
            if (sendAuthResp.errCode == -4) {
                [SVProgressHUD showErrorWithStatus:@"您已拒绝登录授权"];
            } else if (sendAuthResp.errCode == -2) {
                [SVProgressHUD showErrorWithStatus:@"您已取消登录授权"];
            } else {
                [SVProgressHUD showErrorWithStatus:ISNIL(sendAuthResp.errStr)];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWeChatAuthFailed object:nil];

        }
        
    } else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        
        SendMessageToWXResp *sendMessageResp = ((SendMessageToWXResp *)resp);
        
        if (sendMessageResp.errCode == 0) {
            NSLog(@"微信分享成功");
            
//            [self shareSuccessAction];
            
        }
        
    }
    
}

@end
