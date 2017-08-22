//
//  AppDelegate.m
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/7/23.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "AppDelegate.h"
#import "UGirlNVController.h"
#import "ClassViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UMSocialCore/UMSocialCore.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 启动图片延时: 1秒
    [NSThread sleepForTimeInterval:1.5];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //  [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"numberID"];
    NSString *versionKey = @"CFBundleVersion";
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    // 从沙河中取出上次的软件的版本号(用户上次的使用记录 )
    NSString *lastVersion =   [defaults objectForKey:versionKey];
    //    //获取当前版本号
    NSString *currenVersion =  [NSBundle mainBundle].infoDictionary[versionKey];
    //    if ([currenVersion isEqualToString:lastVersion]) {
    // 当钱版本号 == 上次使用的版本号 显示XuTabBarViewController
    //        self.window.rootViewController  = [[LaunchViewController alloc]init];
    ClassViewController *a  = [[ClassViewController alloc]init];
    
    UGirlNVController *nav = [[UGirlNVController alloc]initWithRootViewController:a];
    
    self.window.rootViewController  = nav;
    //    }else{
    // 当钱版本号 != 上次使用的版本号 显示ViewNewFratureController 新特性
    UIViewController*view1 =  [[UIViewController alloc] init];
    view1.view.backgroundColor = [UIColor redColor];
    //        self.window.rootViewController = view1;
    // 储存这次使用的版本号
    [defaults setObject:currenVersion forKey:versionKey];
    // 这句话是马上储存版本号1
    [defaults synchronize];
    //    }
    [self.window makeKeyAndVisible];
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"590d61cf9f06fd59c7001cf1"];
    
    [self configUSharePlatforms];
    
    return YES;
}

- (void)configUSharePlatforms{
      [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx025ba024ecf3364d" appSecret:@"d2a5c30540d94bb923727bc0da7591db" redirectURL:nil];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1761008725"  appSecret:@"fc48148f911c4f40520a336794b66cda" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];

}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
//2.支持目前所有iOS系统

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
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

}


@end
