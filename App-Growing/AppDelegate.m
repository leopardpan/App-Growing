//
//  AppDelegate.m
//  App-Growing
//
//  Created by 潘柏信 on 16/4/14.
//  Copyright (c) 2016年 leopard. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:[[TabBarController alloc] init]];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
