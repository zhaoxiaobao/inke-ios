//
//  AppDelegate.m
//  FFmpegTest
//
//  Created by chenhairong on 15/5/3.
//  Copyright (c) 2015年 times. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    FirstViewController *Vc1=[[FirstViewController alloc] init];
    UINavigationController *nav1=[[UINavigationController alloc] initWithRootViewController:Vc1];
    SecondViewController *Vc2=[[SecondViewController alloc] init];
    UINavigationController *nav2=[[UINavigationController alloc] initWithRootViewController:Vc2];
    ThirdViewController *Vc3=[[ThirdViewController alloc] init];
    UINavigationController *nav3=[[UINavigationController alloc] initWithRootViewController:Vc3];
    Vc1.title=@"关注";
    Vc2.title=@"直播";
    Vc3.title=@"我";
    NSArray *navs=@[nav1,nav2,nav3];
    self.rootTabCtr=[[UITabBarController alloc] init];
    [self.rootTabCtr setViewControllers:navs animated:YES];
    self.window.rootViewController=nav2;
    UITabBar *tabbar=self.rootTabCtr.tabBar;
    UITabBarItem *item1=[tabbar.items objectAtIndex:0];
    UITabBarItem *item2=[tabbar.items objectAtIndex:1];
    UITabBarItem *item3=[tabbar.items objectAtIndex:2];
    
    item1.selectedImage = [[UIImage imageNamed:@"12"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"9"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"13"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"10"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"14"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"11"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(121, 31,211),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];    
    
    
 
    
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
