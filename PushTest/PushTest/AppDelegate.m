//
//  AppDelegate.m
//  PushTest
//
//  Created by 杨小兵 on 15/8/24.
//  Copyright (c) 2015年 杨小兵. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0 )
    {
        [application registerForRemoteNotifications];
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeNone | UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else
    {
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }
    // 如果程序杀死,用下面的方法获取推送的消息
    if (launchOptions)
    {
        NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        NSLog(@"%@",userInfo);
    }
    return YES;}


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
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"%@",deviceToken);
    // 1.上传qq号码 + deviceToken 到qq的服务器
    /**
     *  deviceToken 不是固定 会变
     */
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    // 获取沙盒里旧 deviceToken
    NSString *oldDevToken = [defaults objectForKey:@"deviceToken"];
#warning 提交deviceToken不需要< > 符号 ,也不需要空格
    NSString *newDevToken = [deviceToken description];
    NSLog(@"%@",newDevToken);
    //zhangsan deviceToken:123456
    //zhangsan deviceToken:123488 123499
    // 如果两个deviceToken不相等, 说明deviceToken被改变 重新上新的deviceToken给服务器
    if (![oldDevToken isEqualToString:newDevToken])
    {
        // 1.qq + diviceToken 上传给qq 服务器 ,让qq服务器,把zhangsan 对应 的deviceToken 更改
        // 2.先在本地存储deviceToken
        [defaults setObject:deviceToken forKey:@"deviceToken"];
        [defaults synchronize];
    }
}
@end
