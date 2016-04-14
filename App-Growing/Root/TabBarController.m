//
//  TabBarController.m
//  App-Growing
//
//  Created by 潘柏信 on 16/4/14.
// Copyright © 2016年 leopard. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"

#import "HomePageViewController.h"
#import "DiscoverViewController.h"
#import "MineViewController.h"

#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadChildViewControllers];
    // Do any additional setup after loading the view.
}

- (void)loadChildViewControllers {

    // homepage
    HomePageViewController *hpVC = [[HomePageViewController alloc] init];
    NavigationController *navHp = [[NavigationController alloc] initWithRootViewController:hpVC];

    // discover
    ViewController1 *vc1 = [[ViewController1 alloc] init];
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    ViewController3 *vc3 = [[ViewController3 alloc] init];
    ViewController4 *vc4 = [[ViewController4 alloc] init];
    DiscoverViewController *disVC = [[DiscoverViewController alloc] initWithTitle:@"发现" andSubTitles:@[@"视图1", @"视图2", @"视图3", @"视图4"]andControllers:@[vc1, vc2, vc3,vc4] underTabbar:NO];
    NavigationController *navDic = [[NavigationController alloc] initWithRootViewController:disVC];

    // mine
    MineViewController *mineVC = [[MineViewController alloc] init];
    NavigationController *navMine = [[NavigationController alloc] initWithRootViewController:mineVC];

}

@end
