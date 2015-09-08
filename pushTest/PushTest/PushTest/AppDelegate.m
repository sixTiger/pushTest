//
//  AppDelegate.m
//  PushTest
//
//  Created by 杨小兵 on 15/9/8.
//  Copyright (c) 2015年 杨小兵. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        [application registerForRemoteNotifications];
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
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
    if (launchOptions) {
        NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        NSLog(@"%@",userInfo);
    }
    return YES;
}
/**
 *  获取 deviceToken
 *
 *  @param application application
 *  @param deviceToken 获取的 deviceToken
 */
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"%@",deviceToken);
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    // 获取沙盒里旧 deviceToken
    NSString *oldDevToken = [defaults objectForKey:@"deviceToken"];
    NSString *newDevToken = [deviceToken description];
    NSLog(@"%@",newDevToken);
    if (![oldDevToken.description isEqualToString:newDevToken])
    {
        [defaults setObject:deviceToken forKey:@"deviceToken"];
        [defaults synchronize];
    }
}

//点通知的消息时候 ,会调用这个方法
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    // 获取服务器推送过来的消息
    NSLog(@"%@",userInfo);
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // 获取本地通知的是时候会调用这个方法
    NSLog(@"%@",notification.userInfo);
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
