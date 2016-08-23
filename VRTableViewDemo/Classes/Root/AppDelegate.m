//
//  AppDelegate.m
//  VRTableViewDemo
//
//  Created by Visitor on 16/6/1.
//  Copyright © 2016年 Visitor. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // push project test
    
    return YES;
}

//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    NSLog(@"application Did Become Active");
//}

//- (void)applicationWillResignActive:(UIApplication *)application {
//    NSLog(@"application will resign active");
//}

/**
 *  Application将要从前台进入后台时会触发此函数
 *
 *  @param application 当前应用程序
 */

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"application will resign active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

/**
 *  Application将要从后台进入前台或者挂断电话的时候会触发此函数
 *
 *  @param application 当前应用程序
 */

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"application Did Become Active");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
