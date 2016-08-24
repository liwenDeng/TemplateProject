//
//  AppDelegate.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/6/24.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "AppDelegate.h"
#import "MSBaseTabBarController.h"
#import "MSTabBarControllerConfig.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    /**
//     http://capi.douyucdn.cn/api/v1/room/453751?aid=ios&client_sys=ios&ne=1&support_pwd=1&time=1471851600&auth=91355a5a457cec7bb5a9986e90b2fb6d
//     
//     aid	ios
//     client_sys	ios
//     ne	1
//     support_pwd	1
//     time	1471851600
//     auth	91355a5a457cec7bb5a9986e90b2fb6d
//     */
//    NSString *device = @"RjYwMjUxMkRFMjQwNDMyNDhEMzA2MjlCQ0VENTlCQ0R8Mi4yOTA=";
//    NSString *swf_secret = @"bLFlashflowlad92";
//    NSString *lap_secret = @"A12Svb&%1UUmf@hC";
//    NSString *swf_sign = [NSString stringWithFormat:@"%@%@%@",@"453751",swf_secret,@"1471851600"].ms_md5;
//    NSString *l_sign = [NSString stringWithFormat:@"%@%@%@%@",@"453751",device,lap_secret,@"1471851600"].ms_md5;
//    

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MSTabBarControllerConfig *tabBarConfig = [[MSTabBarControllerConfig alloc]init];
    MSBaseTabBarController *tabBarVC = tabBarConfig.tabBarController;
    [self.window setRootViewController:tabBarVC];
    
    [self.window makeKeyAndVisible];

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

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"接收到本地PUSH");
}

@end
