//
//  ViewController.m
//  PushTest
//
//  Created by 杨小兵 on 15/9/8.
//  Copyright (c) 2015年 杨小兵. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)addNotification:(id)sender;
- (IBAction)addActionNotification:(id)sender;
- (IBAction)cancleNotification:(id)sender;

@end

@implementation ViewController



- (IBAction)addNotification:(id)sender
{
    [self createSimpleLocalNotification];
}

- (IBAction)addActionNotification:(id)sender
{
    
    [self createDifficultLocalNotification];
}

- (IBAction)cancleNotification:(id)sender {
    NSLog(@"取消通知");
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}


/* 在程序中创建一个简单的通知 */

/**
 *  建立一个本地通知
 */
- (void)createSimpleLocalNotification
{
    NSLog(@"添加本地通知");
    // 本地推送
    //一个本地通知就是一个任务
    // 1.创建 本地通知对象
    UILocalNotification *localNoti = [[UILocalNotification alloc] init];
    // 2.通知提醒的时间 多少时间以后提醒
    localNoti.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    //设置时区 默认时区就好跟 defaultTimeZone
    localNoti.timeZone = [NSTimeZone defaultTimeZone];
    // 3.设置通知的内容
    localNoti.alertBody = @"女友的生日到了";
    // 4.设置锁屏的时显示消息
    localNoti.alertAction = @"xxxx";
    // 5.设置 点通知后 启动程序时的图片 默认情况下没有 应该设置成和程序的启动界面一样
    localNoti.alertLaunchImage = @"LaunchImage";
    // 6.设置图标右上角数字 马上就有 只会执行一次 不管通知多烧毁都只会执行一次
    localNoti.applicationIconBadgeNumber ++;
    // 7.设置通知重复的间隔 最好不要重复 不会
    localNoti.repeatInterval = NSCalendarUnitSecond;
    // 8.添加额外的信息 可以在userInfo中找到
    localNoti.userInfo = @{@"detail": @"中午送花到公司 晚上烛光晚餐"};
    // 执行本地通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
}

/* 在程序中创建一个复杂点的通知 */

/**
 *  建立一个本地通知
 */
- (void)createDifficultLocalNotification
{
    
    //1.创建消息上面要添加的动作(按钮的形式显示出来)
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
    action.identifier = @"action";//按钮的标示
    action.title=@"马上处理";//按钮的标题
    action.activationMode = UIUserNotificationActivationModeForeground;
    //    action.authenticationRequired = YES;
    //    action.destructive = YES;
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
    action2.identifier = @"action2";
    action2.title=@"稍后处理";
    action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    
    //开启的画则为进入程序 否则为取消通知
    action.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action.destructive = YES;
    
    //2.创建动作(按钮)的类别集合
    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    categorys.identifier = @"alert";//这组动作的唯一标示
    [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextMinimal)];
    
    //3.创建UIUserNotificationSettings，并设置消息的显示类类型
    UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
    
    //4.注册推送
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    /**
     ios8 需要注册通知
     */
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    // 本地推送
    //一个本地通知就是一个任务
    // 1.创建 本地通知对象
    UILocalNotification *localNoti = [[UILocalNotification alloc] init];
    // 2.通知提醒的时间 多少时间以后提醒
    localNoti.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    //设置时区 默认时区就好跟 defaultTimeZone
    localNoti.timeZone = [NSTimeZone defaultTimeZone];
    // 3.设置通知的内容
    localNoti.alertBody = @"通知来了";
    // 4.设置锁屏的时显示消息
    localNoti.alertAction = @"xxxx";
    // 5.设置 点通知后 启动程序时的图片 默认情况下没有 应该设置成和程序的启动界面一样
    localNoti.alertLaunchImage = @"LaunchImage";
    // 6.设置图标右上角数字 马上就有 只会执行一次 不管通知多烧毁都只会执行一次
    localNoti.applicationIconBadgeNumber = 100;
    // 7.设置通知重复的间隔 最好不要重复 不会
    localNoti.repeatInterval = NSCalendarUnitSecond;
    // 8.添加额外的信息 可以在userInfo中找到
    localNoti.userInfo = @{@"detail": @"中午送花到公司 晚上烛光晚餐"};
    // 执行本地通知
    
    localNoti.category = @"alert";
    [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
}
@end
