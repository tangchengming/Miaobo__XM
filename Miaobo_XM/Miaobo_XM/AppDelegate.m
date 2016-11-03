//
//  AppDelegate.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 16/9/23.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "AppDelegate.h"
#import "XMLoginViewController.h"
//

//


//



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    XMLoginViewController *login = [[XMLoginViewController alloc] init];
    self.window.rootViewController = login;
    [self.window makeKeyAndVisible];
    
    
    //
    
    [ShareSDK registerApp:ShareAppKey activePlatforms:@[@(SSDKPlatformTypeQQ),@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeWechat)] onImport:^(SSDKPlatformType platformType) {
        
        switch (platformType) {
                
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
                
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
                
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
                
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        
        switch (platformType) {
                
            case SSDKPlatformTypeSinaWeibo:
                
                //设置新浪微博应用信息，其中authType设置为使用sso＋web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:@"3469721500" appSecret:@"e7118115d68e6ba185c08e82d5fe2cbc" redirectUri:@"http://www.sharesdk.cn" authType:SSDKAuthTypeBoth];
                
                break;
                
            //微信
            case SSDKPlatformTypeWechat:
                
                [appInfo SSDKSetupWeChatByAppId:@"wxe6b5b748cdcff60f" appSecret:@"d4624c36b6795d1d99dcf0547af5443d"];
                
                
                break;
                
                //qq
            case SSDKPlatformTypeQQ:
                
                [appInfo SSDKSetupQQByAppId:@"1105750416" appKey:@"jRP14t66OKrc2yLJ" authType:SSDKAuthTypeBoth];
                
                break;

                
            default:
                break;
        }
        
        
    }];
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
